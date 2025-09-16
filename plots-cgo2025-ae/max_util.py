from typing import Sequence
import pandas as pd

from data import Impl, Operator


def get_max_util(llr_kernels_df: pd.DataFrame, fpu_dfs: Sequence[pd.DataFrame]) -> str:
    llr_max_occupancy = llr_kernels_df["fpss_fpu_occupancy"].max()
    llr_max_throughput = llr_kernels_df["Rel Throughput"].max()
    llr_matmult_throughput = llr_kernels_df["Throughput"][
        Operator.MATMUL_TRANSB, :
    ].max()
    llr_matmult_max_occupancy = llr_kernels_df["fpss_fpu_occupancy"][
        Operator.MATMUL_TRANSB, :
    ].max()
    proto_comp_max_occupancy = max(fpu_df[Impl.OURS].max() for fpu_df in fpu_dfs)
    proto_comp_min_max_occupancy = min_max = min(
        _df[Impl.OURS].max() for _df in fpu_dfs
    )
    clang_max_occupancy = max(fpu_df[Impl.CLANG].max() for fpu_df in fpu_dfs)

    return f"""\
Section 4.2 Maximum FPU utilization for low-level representations, {llr_max_occupancy*100:.0f}%
Section 4.2 Maximum FPU utilization for low-level representation MatMulT, {llr_matmult_max_occupancy*100:.0f}%
Section 4.2 Percent of maximum theoretical throughput achieved for low-level representations, {llr_max_throughput*100:.0f}%
Section 4.2 Maximum throughput achieved for low-level representation MatMulT, {llr_matmult_throughput:.2f}
Section 4.4 Maximum FPU utilization for prototype micro-kernel compiler, {proto_comp_max_occupancy*100:.0f}%
Section 4.4 Minimum FPU utilization for prototype micro-kernel compiler, {proto_comp_min_max_occupancy*100:.0f}%
Section 4.4 Maximum FPU utilization for Clang, {clang_max_occupancy*100:.0f}%
"""
