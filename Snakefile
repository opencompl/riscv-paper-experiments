configfile: "default.yaml"


C_VARIANTS = [
    "baseline",  # naive c
    "snrt",  # optimized c + inline asm for snitch festures
    "fused",  # optimized c + inline asm for snitch festures with manual fusion of reduction/elementwise loop nests
]

XDSL_LINALG_OPT_VARIANTS = [
    "linalg_0_xdsl",  # incremental insertion of xDSL passes
    "linalg_1_xdsl",  # incremental insertion of xDSL passes
    "linalg_2_xdsl",  # incremental insertion of xDSL passes
    "linalg_3_xdsl",  # incremental insertion of xDSL passes
    "linalg_4_xdsl",  # incremental insertion of xDSL passes
    "linalg_5_xdsl",  # should run the same passes as linalg_xdsl but via a fully expanded pipeline instead of xdsl-opt test passes/mini-pipelines
]

XDSL_LINALG_VARIANTS = [
    "linalg_xdsl",  # xDSL lowering from linalg on tensors
    *XDSL_LINALG_OPT_VARIANTS,
]

XDSL_VARIANTS = [
    *XDSL_LINALG_VARIANTS,
    "snitch_stream",  # xDSL lowering from snitch_stream dialect
    "riscv_scf",  # xDSL lowering from riscv_scf dialect
]

MLIR_VARIANTS = [
    "linalg",  # naive mlir lowering from linalg on tensors
    "scf",  # naive mlir lowering from scf on memrefs
]

###########################################################
# Templated kernels, sources and data need to be
# generated on the fly
###########################################################

# Regular expressions to parse test shape (e.g.: 4x8xf64)
# Make sure dimensions in code match capture group names below:
SHAPE_2D = r"(?P<M>\d+)x(?P<N>\d+)xf(?P<precision>\d+)"
SHAPE_3D = r"(?P<M>\d+)x(?P<K>\d+)x(?P<N>\d+)xf(?P<precision>\d+)"

# Shape regex for each kernel
# Beware: the presence in the following dict makes the kernel
# a templated kernel. Dict keys below are used to enable
# source/data generation rules.
KERNEL_SHAPE = {
    "sum": SHAPE_2D,
    "relu": SHAPE_2D,
    "fill": SHAPE_2D,
    "conv2d_d1_s1_3x3": SHAPE_2D,
    "pooling_nchw_sum_d1_s2_3x3": SHAPE_2D,
    "pooling_nchw_max_d1_s2_3x3": SHAPE_2D,
    "matmul": SHAPE_3D,
    "matmul_transb": SHAPE_3D,
}

KERNEL_TEMPLATES = KERNEL_SHAPE.keys()

# Common values to be added to params.json
PARAMS = {
    "rmin": -1000.0,
    "rmax": 1000.0,
}

###########################################################
# Manual kernels, sources and data provided as inputs
###########################################################

MANUAL_KERNELS = [
    *expand("saxpy/64xf32/{variant}", variant=["baseline", "snrt", "linalg"]),
    *expand(
        "ddot/128xf64/{variant}",
        variant=["baseline", "snrt", "snitch_stream", "linalg", "riscv_scf", "scf"],
    ),
    *expand(
        "dense/8x8xf64/{variant}",
        variant=["baseline", "snrt", "snitch_stream", "linalg", "fused"],
    ),
]

###########################################################
# Test sets
###########################################################

# Minimum set of tests to be used as a meaningful smoke test,
# runs as fast as possible to save CI time
TESTSET_FAST = [
    *MANUAL_KERNELS,
    # 3d templated kernels
    *expand(
        "matmul_transb/4x16x16xf32/{variant}",
        variant=["baseline", "snrt", "snitch_stream"],
    ),
    *expand(
        "matmul/4x16x8xf64/{variant}",
        variant=["baseline", "linalg_xdsl"],
    ),
    # 2d templated kernels: baseline + linalg_xdsl
    *expand(
        "{kernel}/4x4xf64/{variant}",
        kernel=[
            "sum",
            "fill",
            "relu",
            "pooling_nchw_sum_d1_s2_3x3",
            "pooling_nchw_max_d1_s2_3x3",
            "conv2d_d1_s1_3x3",
        ],
        variant=["baseline", "linalg_xdsl"],
    ),
    *expand(
        "relu/4x8xf32/{variant}", variant=["baseline", "linalg", "snrt", "snitch_stream"]
    ),
    *expand(
        "sum/4x8xf32/{variant}", variant=["baseline", "snrt", "linalg", "linalg_xdsl"]
    ),
    *expand("sum/8x8xf16/{variant}", variant=["baseline", "linalg_xdsl"]),
    *expand("matmul/1x20x5xf64/{phase}", phase=XDSL_LINALG_OPT_VARIANTS),
]

TESTSET_LOW_LEVEL_REPRESENTATION = [
    *expand(
        "{kernel}/20x{N}xf32/{variant}",
        kernel=[
            "relu",
        ],
        N=[4, 8, 12, 16, 20],
        variant=["snitch_stream"],
    ),
    *expand(
        "{kernel}/{M}x20xf32/{variant}",
        kernel=[
            "relu",
        ],
        M=[4, 8, 12, 16, 20],
        variant=["snitch_stream"],
    ),
    *expand(
        "{kernel}/20x{N}xf32/{variant}",
        kernel=[
            "sum",
        ],
        N=[4, 8, 12, 16, 20],
        variant=["linalg_xdsl"],
    ),
    *expand(
        "{kernel}/{M}x20xf32/{variant}",
        kernel=[
            "sum",
        ],
        M=[4, 8, 12, 16, 20],
        variant=["linalg_xdsl"],
    ),
]

# Full set. Contains all tests needed by plots in the paper. Beware: it's huge.
TESTSET_ALL = [
    *MANUAL_KERNELS,
    *TESTSET_LOW_LEVEL_REPRESENTATION,
    # 3d templated kernels: baseline + linalg_xdsl
    *expand(
        "matmul/{M}x{K}x{N}xf64/{variant}",
        M=[4, 8],
        K=range(4, 65, 4),
        N=range(4, 65, 4),
        variant=["baseline", "linalg_xdsl"],
    ),
    # Passes contributions
    "matmul/1x400x25xf64/linalg_xdsl",
    "matmul/1x400x25xf64/linalg_full_xdsl",
    *expand("matmul/1x400x25xf64/{phase}", phase=XDSL_LINALG_OPT_VARIANTS),
    # 2d templated kernels: baseline + linalg_xdsl
    *expand(
        "{kernel}/{M}x{N}xf64/{variant}",
        kernel=[
            "sum",
            "fill",
            "relu",
            "pooling_nchw_sum_d1_s2_3x3",
            "pooling_nchw_max_d1_s2_3x3",
            "conv2d_d1_s1_3x3",
        ],
        M=[4, 8, 12, 16, 20],
        N=[4, 8, 12, 16, 20],
        variant=["baseline", "linalg_xdsl"],
    ),
    *expand(
        "sum/{M}x{N}xf32/{variant}",
        variant=["baseline", "snrt", "linalg", "linalg_xdsl"],
        M=[4, 8],
        N=range(4, 65, 4),
    ),
    *expand(
        "sum/{M}x{N}xf16/{variant}",
        variant=["baseline", "linalg_xdsl"],
        M=[4, 8],
        N=range(4, 65, 4),
    ),
]


# Return the list of expected execution profile files according to the
# selected 'testset' output wildcard
def select_test_set_profiles(wildcards) -> list[str]:
    sets = {
        "fast": sorted(set(TESTSET_FAST)),
        "all": sorted(set(TESTSET_ALL)),
        "low_level_representation": sorted(set(TESTSET_LOW_LEVEL_REPRESENTATION))
    }
    name = wildcards.testset
    if name not in sets:
        raise ValueError(
            f"unknown test set name '{name}', valid values are: {sets.keys()}"
        )
    return expand("kernels/{test}.profile.json", test=sets[name])


###########################################################
# Target rules
###########################################################


rule fast:
    input:
        "results/kernels.fast.csv",
        "results/pivoted.fast.csv",
        "results/pivoted_fpu.fast.csv",
        "results/pivoted_ipc.fast.csv",
        "results/regalloc.fast.csv",
        "results/pipeline.fast.csv",
    # This is the default rule taking over former result
    # file names:
    output:
        "results/kernels.csv",
        "results/pivoted.csv",
        "results/pivoted_fpu.csv",
        "results/pivoted_ipc.csv",
    shell:
        """
        cp -f results/kernels.fast.csv results/kernels.csv
        cp -f results/pivoted.fast.csv results/pivoted.csv
        cp -f results/pivoted_fpu.fast.csv results/pivoted_fpu.csv
        cp -f results/pivoted_ipc.fast.csv results/pivoted_ipc.csv
        """

rule low_level_representation:
    input:
        "results/kernels.low_level_representation.csv"

rule all:
    input:
        "results/kernels.all.csv",
        "results/pivoted.all.csv",
        "results/pivoted_fpu.all.csv",
        "results/pivoted_ipc.all.csv",


###########################################################
# Rules
###########################################################


rule csv_to_pivoted:
    input:
        kernels="results/kernels.{testset}.csv",
        pivot="scripts/pivot.py",
    output:
        "results/pivoted.{testset}.csv",
        "results/pivoted_fpu.{testset}.csv",
        "results/pivoted_ipc.{testset}.csv",
    shell:
        """
        {input.pivot} --outdir {resources.tmpdir} < {input.kernels}
        mv -f {resources.tmpdir}/pivoted.csv results/pivoted.{wildcards.testset}.csv
        mv -f {resources.tmpdir}/pivoted_fpu.csv results/pivoted_fpu.{wildcards.testset}.csv
        mv -f {resources.tmpdir}/pivoted_ipc.csv results/pivoted_ipc.{wildcards.testset}.csv
        """


rule profile_to_csv:
    input:
        select_test_set_profiles,
    output:
        "results/kernels.{testset}.csv",
    params:
        profile_to_csv="scripts/profile_to_csv.py",
    shell:
        "{params.profile_to_csv} {input} -o {output}"


rule trace_to_profile:
    input:
        txt="kernels/{kernel}/{shape}/{variant}.logs/trace_hart_00000000.trace.txt",
        json="kernels/{kernel}/{shape}/{variant}.logs/trace_hart_00000000.trace.json",
    output:
        "kernels/{kernel}/{shape}/{variant}.profile.json",
    params:
        trace_to_profile="scripts/trace_to_profile.py",
    shell:
        """
        {params.trace_to_profile} --section 1 \
          --add section 1 \
          --add test {wildcards.kernel} \
          --add params {wildcards.shape} \
          --add impl {wildcards.variant} \
          -o {output} {input.txt} {input.json}
        """


rule dasm_to_trace:
    input:
        "{test}.logs/trace_hart_00000000.dasm",
    output:
        txt="{test}.logs/trace_hart_00000000.trace.txt",
        json="{test}.logs/trace_hart_00000000.trace.json",
    params:
        spike=config["spike"],
        gentrace=config["gentrace"],
    shell:
        "{params.spike} < {input} | {params.gentrace} --permissive -d {output.json} > {output.txt}"


# Rule used to generate traces for debugging purposes, not used for csv generation
rule dasm_to_trace_debug:
    input:
        "{test}.logs/logs/trace_hart_00000000.dasm",
    output:
        txt="{test}.logs/logs/trace_hart_00000000.trace.txt",
    params:
        spike=config["spike"],
        gentrace=config["gentrace"],
    shell:
        "{params.spike} < {input} | {params.gentrace} --permissive > {output.txt}"


rule verilator:
    input:
        "{test}.x",
    output:
        expand("{{test}}.logs/trace_hart_0000000{hart}.dasm", hart=range(9)),
    params:
        workdir="{test}.logs",
        vltsim=config["vltsim"],
    shell:
        """
        mkdir -p {params.workdir}/logs
        cd {params.workdir}
        {params.vltsim} ../$(basename {input})
        mv -f logs/* .
        rm -fr logs
        """


rule assembly_to_regalloc_stats:
    input:
        asm="{test}.S",
        stats_script="scripts/regalloc_stats.awk",
    output:
        "{test}.regalloc.json",
    shell:
        """
        awk -f {input.stats_script} {input.asm} > {output}
        """


rule combine_regalloc_stats:
    input:
        *expand("kernels/{test}.regalloc.json", test=TESTSET_FAST),
    output:
        "kernels/regalloc.fast.jsonl",
    shell:
        "cat {input} > {output}"


rule count_frep_instructions:
    input:
        expand("kernels/matmul/1x20x5xf64/{test}.S", test=XDSL_LINALG_OPT_VARIANTS)
    output:
        "results/frep_count.fast.csv"
    shell:
        """
        echo "variant,frep_count" > {output}
        for file in {input}; do
            variant=$(basename $file .S)
            count=$(grep -c "frep.o" $file || true)
            echo "$variant,$count" >> {output}
        done
        """


rule regalloc_stats_to_csv:
    input:
        "kernels/regalloc.fast.jsonl",
    output:
        "results/regalloc.fast.csv",
    run:
        import pandas as pd

        df = pd.read_json(input[0], lines=True)
        df = df[df.variant == "linalg_xdsl"]
        del df["preallocated_int"]
        del df["preallocated_float"]
        del df["variant"]
        df.set_index(["impl", "params"], inplace=True)
        df.to_csv(output[0], index=True)


rule pipeline:
    input:
        kernels="results/kernels.fast.csv",
        regalloc="kernels/regalloc.fast.jsonl",
        frep_count="results/frep_count.fast.csv",
        pipeline_py="scripts/pipeline.py",
    output:
        "results/pipeline.fast.csv",
    shell:
        "python {input.pipeline_py} {input.kernels} {input.regalloc} {input.frep_count} -o {output}"


rule optimization_pipelines:
    input:
        passes = "kernels/optimization_passes.txt",
        get_pipeline = "scripts/get_pipeline.py",
    output:
        "kernels/optimization_pipeline.txt",
    shell:
        "python {input.get_pipeline} {input.passes} > {output}"

# Build rules


rule cc_link:
    input:
        "kernels/{kernel}/{shape}/{variant}.o",
        "kernels/{kernel}/{shape}/data.o",
        "kernels/{kernel}/{shape}/main.o",
    output:
        "kernels/{kernel}/{shape}/{variant}.x",
    params:
        cc=config["cc"],
        ldflags=config["ldflags"],
    shell:
        "{params.cc} {params.ldflags} -o {output} {input}"


rule cc_assemble:
    input:
        "{source}.S",
    output:
        "{source}.o",
    params:
        cc=config["cc"],
        asflags=config["asflags"],
    shell:
        "{params.cc} {params.asflags} -c -o {output} {input}"


rule mlir_linalg_compile:
    input:
        "{source}.mlir",
    output:
        "{source}.ll",
    params:
        xdsl_opt=config["xdsl-opt"],
        mlir_opt=config["mlir-opt"],
        mlir_translate=config["mlir-translate"],
        mlir_opt_flags_linalg=config["mlir-opt-flags-linalg"],
        mlir_opt_flags_scf=config["mlir-opt-flags-scf"],
        tollvm12="scripts/tollvm12.py",
    shell:
        """
        {params.mlir_opt} {params.mlir_opt_flags_linalg} {input} \
        | sed 's/arith.maxf/arith.maximumf/g' \
        | {params.xdsl_opt} -p arith-add-fastmath \
        | sed 's/arith.maximumf/arith.maxf/g' \
        | {params.mlir_opt} {params.mlir_opt_flags_scf} \
        | {params.mlir_translate} -opaque-pointers=0 --mlir-to-llvmir \
        | {params.tollvm12} > {output}
        """


###########################################################
# Assembly rules
# Beware: all of the following rules are potentially
# ambiguous since they all produce a .S file.
# To discriminate, we constrain the kernel variant.
###########################################################


rule cc_compile_c:
    input:
        c="kernels/{kernel}/{shape}/{variant}.c",
        h="kernels/{kernel}/{shape}/data.h",
    output:
        "kernels/{kernel}/{shape}/{variant}.S",
    wildcard_constraints:
        variant="|".join(["data", "main"] + C_VARIANTS),
    params:
        cc=config["cc"],
        cflags=config["cflags"],
    shell:
        "{params.cc} -I$(dirname {input}) -I$(dirname {output}) {params.cflags} -S -o {output} {input.c}"


rule cc_compile_ll:
    input:
        "kernels/{kernel}/{shape}/{variant}.ll",
    output:
        "kernels/{kernel}/{shape}/{variant}.S",
    wildcard_constraints:
        variant="|".join(MLIR_VARIANTS),
    params:
        cc=config["cc"],
        cflags=config["cflags"],
    shell:
        "{params.cc} {params.cflags} -S -o {output} {input}"


def filter_xdsl_pipeline_passes(wildcards):
    import re

    if wildcards.variant == "linalg_full_xdsl":
        return ",".join(config["xdsl-passes"])

    match = re.search(r"linalg_(\d)_xdsl", wildcards.variant)
    if not match:
        return ",".join(config["xdsl-passes"])

    opt_level = match.group(1)
    opt_level = int(opt_level)

    with open("kernels/optimization_pipeline.txt") as f:
        return f.read().splitlines()[opt_level]


rule xdsl_compile:
    input:
        xdsl_input="kernels/{kernel}/{shape}/{variant}.xdsl.mlir",
        xdsl_commit=config["xdsl_commit"],
        optimization_pipelines="kernels/optimization_pipeline.txt"
    output:
        "kernels/{kernel}/{shape}/{variant}.S",
    wildcard_constraints:
        variant="|".join(XDSL_VARIANTS),
    params:
        xdsl_opt=config["xdsl-opt"],
        passes=filter_xdsl_pipeline_passes,
    shell:
        """
        sed 's/arith.maxf/arith.maximumf/g' {input.xdsl_input} \
        | {params.xdsl_opt} -p {params.passes} -t riscv-asm -o {output}
        """


# Specific rules for shared source files,
# a.k.a. where the input source is in another directory WRT output


rule cc_compile_shared_main:
    input:
        c="kernels/{kernel}/main.c",
        h="kernels/{kernel}/{shape}/data.h",
    output:
        "kernels/{kernel}/{shape}/main.S",
    params:
        cc=config["cc"],
        cflags=config["cflags"],
    shell:
        "{params.cc} -I$(dirname {input.h}) {params.cflags} -S -o {output} {input.c}"


###########################################################
# Sources/data generation rules, restricted to templated
# kernels only
###########################################################


rule kernel_generate_params:
    output:
        "kernels/{kernel}/{shape}/params.json",
    wildcard_constraints:
        kernel="|".join(KERNEL_TEMPLATES),
    run:
        import re
        import json

        pattern = re.compile(KERNEL_SHAPE[wildcards.kernel])
        match = pattern.fullmatch(wildcards.shape)
        assert match
        params = {k: int(v) for k, v in match.groupdict().items()}
        params.update(PARAMS)
        with open(output[0], "w") as out:
            json.dump(params, out, indent=4)


rule kernel_generate_data_h:
    input:
        json="kernels/{kernel}/{shape}/params.json",
        template="kernels/{kernel}/data.h.template",
    output:
        "kernels/{kernel}/{shape}/data.h",
    wildcard_constraints:
        kernel="|".join(KERNEL_TEMPLATES),
    params:
        format_template="scripts/format.py",
    shell:
        "python3 {params.format_template} {input.template} {input.json} > {output}"


rule kernel_generate_data_c:
    input:
        json="kernels/{kernel}/{shape}/params.json",
        h="kernels/{kernel}/{shape}/data.h",
    output:
        "kernels/{kernel}/{shape}/data.c",
    wildcard_constraints:
        kernel="|".join(KERNEL_TEMPLATES),
    shell:
        "PYTHONPATH=kernels python3 -m kernels.{wildcards.kernel}.gendata -p {input.json} > {output}"


rule kernel_generate_source:
    input:
        json="kernels/{kernel}/{shape}/params.json",
        template="kernels/{kernel}/{variant}.{ext}.template",
    output:
        "kernels/{kernel}/{shape}/{variant}.{ext}",
    wildcard_constraints:
        ext="c|mlir",
        kernel="|".join(KERNEL_TEMPLATES),
    params:
        format_template="scripts/format.py",
    shell:
        "python3 {params.format_template} {input.template} {input.json} > {output}"


rule xdsl_kernel_generate_source:
    input:
        json="kernels/{kernel}/{shape}/params.json",
        template="kernels/{kernel}/linalg.mlir.template",
    output:
        "kernels/{kernel}/{shape}/{variant}.xdsl.mlir",
    wildcard_constraints:
        kernel="|".join(KERNEL_TEMPLATES),
        variant="|".join(XDSL_LINALG_VARIANTS),
    params:
        format_template="scripts/format.py",
        xdsl_opt=config["xdsl-opt"],
        mlir_opt=config["mlir-opt"],
        mlir_opt_flags_linalg=config["mlir-opt-flags-linalg"],
    shell:
        """
        python3 {params.format_template} {input.template} {input.json} \
        | {params.mlir_opt} {params.mlir_opt_flags_linalg} \
        | sed 's/arith.maxf/arith.maximumf/g' \
        | {params.xdsl_opt} -p arith-add-fastmath \
        | sed 's/arith.maximumf/arith.maxf/g' > {output}
        """
