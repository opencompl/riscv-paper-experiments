# riscv-paper-experiments

## RTL Simulation Quickstart

Let's start by spinning up the `snitch-toolchain` Docker container and mounting
a clone of this repo inside it at `/src`:

```shell
$ git clone https://github.com/opencompl/riscv-paper-experiments.git
$ docker run --rm -ti --volume $PWD/riscv-paper-experiments:/src ghcr.io/nazavode/snitch-toolchain:latest bash
```

Alternatively, the current flow can be performed with:

```shell
$ docker run --rm -ti --volume $PWD/riscv-paper-experiments:/src ghcr.io/nazavode/snitch-toolchain:latest /src/scripts/run.sh
```

This builds the kernels, executes them with Verilator, process the traces from these runs and plots the results.
The results can be found under the `results` subdirectory within the repo.
Each result file is uniquely tagged with a date and time suffix.

*Note: `opencompl` members seem not to have enough rights to push packages to the organization's
package registry. The image built from [`snitch/docker/Dockerfile`](snitch/docker/Dockerfile) is
currently made available at:
[`ghcr.io/nazavode/snitch-toolchain:latest`](https://github.com/users/nazavode/packages/container/package/snitch-toolchain)*

*Note: if on macOS, be aware that the official Docker app is trash, [OrbStack](https://orbstack.dev/)
is highly recommended instead.*

*Note: if you're running Docker on an architecture other than `x86_64` (e.g.: Apple Silicon),
it's likely that your `docker run` command will complain about the image being `linux/amd64`.
Add the following option to explicitly ask for a specific platform:*

```shell
$ docker run --platform linux/amd64 ...
```

To build a RISC-V executable, start from one of the kernels:

```shell
$ cd /src/kernels/saxpy/64xf32/
$ make linalg.x
$ ls *.x
linalg.x
```

The [Makefile](kernels/saxpy/64xf32/Makefile) performs the following steps:

1. `.mlir` -> `.ll.mlir` (a.k.a. MLIR source that uses the LLVM dialect only) via `mlir-opt`
2. `.ll.mlir` -> `.ll` via `mlir-translate`
3. `.ll` -> `.ll12` (a.k.a. LLVM IR backported to a form compatible with LLVM 12) via [`tollvm12.py`](snitch/tollvm12.py)
4. `.ll12` -> `.o` via `clang`
5. `.o` -> `.x` via `lld`, linking the runtime and using the correct linker script to lay out the ELF file.

Once the ELF executable is ready, we can simulate its execution on a Snitch
cluster via the RTL simulator generated by Verilator:

```shell
$ make run_linalg.x
/opt/snitch-rtl/bin/snitch_cluster.vlt linalg.x
Warning: Failed to write binary name to logs/.rtlbinary
Wrote 36 bytes of bootrom to 0x1000
Wrote entry point 0x80000000 to bootloader slot 0x1020
Wrote 38 bytes of bootdata to 0x1024
[Tracer] Logging Hart          8 to logs/trace_hart_00000008.dasm
[Tracer] Logging Hart          0 to logs/trace_hart_00000000.dasm
[Tracer] Logging Hart          1 to logs/trace_hart_00000001.dasm
[Tracer] Logging Hart          2 to logs/trace_hart_00000002.dasm
[Tracer] Logging Hart          3 to logs/trace_hart_00000003.dasm
[Tracer] Logging Hart          4 to logs/trace_hart_00000004.dasm
[Tracer] Logging Hart          5 to logs/trace_hart_00000005.dasm
[Tracer] Logging Hart          6 to logs/trace_hart_00000006.dasm
[Tracer] Logging Hart          7 to logs/trace_hart_00000007.dasm
$ echo $?
0
```

*Note: while the `main` function is run by all the compute cores in the cluster,
the current startup code **returns the integer return value of the core no. 0 only**,
**return values of cores other than no. 0 are discarded**.*

To disassemble and decode the execution traces:

```shell
$ make traces
$ ls linalg.x.logs/
linalg.x.logs/trace_hart_00000000.trace.txt  # decoded trace
linalg.x.logs/trace_hart_00000000.trace.json # json performance data per section 
# ...
```

*Note: the current version of `spike-dasm` included in the Docker image doesn't support
Snitch custom instructions: while side effects are reported correctly, they show up as
`unknown` in the decoded trace.*

For each `snrt_mcycle()` call, the cycle timeline for the core is split in two regions,
before and after the call. In our [test runner](kernels/saxpy/64xf32/main.c)
where we call `snrt_mcycle()` right before and after the measured kernel, we have the
following sequence of sections with the middle one being the one related to the kernel itself:

```shell
$ cat linalg.x.logs/trace_hart_00000000.trace.json
Performance metrics for section 0 @ (12, 719):
# ...

Performance metrics for section 1 @ (721, 1448):
tstart                                         0.0
fpss_loads                                     129
fpss_stores                                     64
tend                                           0.0
snitch_loads                                     0
snitch_avg_load_latency                          0
snitch_occupancy                            0.4332
snitch_fseq_rel_offloads                    0.4923
fseq_yield                                     1.0
fseq_fpu_yield                                 1.0
fpss_section_latency                            36
fpss_avg_fpu_latency                        3.1736
fpss_avg_load_latency                       1.0775
fpss_occupancy                              0.4202
fpss_fpu_occupancy                          0.1584
fpss_fpu_rel_occupancy                      0.3769
cycles                                         764
total_ipc                                   0.8534

Performance metrics for section 2 @ (1450, 3227):
# ...
```

Along with performance stats, the execution trace shows each instruction's
dispatch and retirement along the core's cycle timeline:

```shell
$ grep -B2 -A3 1322 linalg.x.logs/trace_hart_00000000.trace.txt
1320 M 0x800001e0 flw     ft0, 0(a5)    #; ft0  <~~ Word[0x100000c4]
1321 M 0x800001e8 flw     ft1, 0(a5)    #; ft1  <~~ Word[0x100001c4], (f:lsu) ft0  <-- 140.3935394
1322 M 0x800001ec fmul.s  ft0, ft0, fa0 #; ft0  = 140.3935394, fa0  = 97.6270065, (f:lsu) ft1  <-- 627.5956421
1323 M 0x800001f4 add     a5, a2, a3    #; a2  = 0x10000200, a3  = 208, (wrb) a5  <-- 0x100002d0
1324 M 0x800001f8 addi    a3, a3, 4     #; a3  = 208, (wrb) a3  <-- 212
1325 M                                  #; (f:fpu) ft0  <-- 13706.2011719

```

From the decoded trace we can see that we are spending:

* 2 cycles to load `rd`/`rs1` from L1 (cycles `1320:1321`,
  the constant was already materialized in `fa0`)
* 4 cycles to perform the actual multiplication (cycles `1322:1325`)

We can also check that the core is doing what we expect:

```shell
$ grep fmul\.s linalg.x.logs/trace_hart_00000000.trace.txt  | wc -l
64
$ grep fmul\.s linalg.x.logs/trace_hart_00000001.trace.txt  | wc -l
0
```

The core (a.k.a. *hart* in RISC-V jargon) no. 0 was the only one actually
executing the kernel, while all of the other cores did none as they early-return
from the `main` function.

## Scripts

### Setup

Setup and activate a Python virtual environment for the scripts:

```shell
$ python3 -m venv venv
$ source venv/bin/activate
$ pip install -r requirements.txt
```

### Collecting Results

We can collect results from the Verilator JSON trace logs in a CSV file with:

```shell
$ scripts/harvest_results.py -s kernels/ -f kernel size version cycles -e cycles -o output[.csv | .json]
```

- `-f` is list of strings that are going to be used as a header row in the CSV file.
- `-e` is list of strings that define field names in the JSON trace to be extracted.

The script assumes that the root search directory follows a directory structure as follows:

`[KERNEL]/[SIZE]/[EXECUTABLE_NAME].x.logs/`

where `KERNEL` is the microkernel name and `SIZE` is its dimensions.

Only log file with name `trace_hart_00000000.trace.json` are used for now.

### Plotting Results

We can plot a grouped barchart using Matplotlib from the previous step's extracted CSV file with:

```shell
$ scripts/plotting/plot_barchart.py -f output.csv -s scripts/plotting/configs/cycles/barchart.mplstyle -c scripts/plotting/configs/cycles/barchart.json
$ ls output.pdf
```

The `.mplstyle` controls plotting stylistic options.
Since Matplotlib style files cannot control all aspects of a plot, we also include a JSON config file.
