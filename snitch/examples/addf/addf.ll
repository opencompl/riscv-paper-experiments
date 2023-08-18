; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

@A = constant [16 x [8 x float]] [[8 x float] [float 0.000000e+00, float 1.000000e+00, float 2.000000e+00, float 3.000000e+00, float 4.000000e+00, float 5.000000e+00, float 6.000000e+00, float 7.000000e+00], [8 x float] [float 8.000000e+00, float 9.000000e+00, float 1.000000e+01, float 1.100000e+01, float 1.200000e+01, float 1.300000e+01, float 1.400000e+01, float 1.500000e+01], [8 x float] [float 1.600000e+01, float 1.700000e+01, float 1.800000e+01, float 1.900000e+01, float 2.000000e+01, float 2.100000e+01, float 2.200000e+01, float 2.300000e+01], [8 x float] [float 2.400000e+01, float 2.500000e+01, float 2.600000e+01, float 2.700000e+01, float 2.800000e+01, float 2.900000e+01, float 3.000000e+01, float 3.100000e+01], [8 x float] [float 3.200000e+01, float 3.300000e+01, float 3.400000e+01, float 3.500000e+01, float 3.600000e+01, float 3.700000e+01, float 3.800000e+01, float 3.900000e+01], [8 x float] [float 4.000000e+01, float 4.100000e+01, float 4.200000e+01, float 4.300000e+01, float 4.400000e+01, float 4.500000e+01, float 4.600000e+01, float 4.700000e+01], [8 x float] [float 4.800000e+01, float 4.900000e+01, float 5.000000e+01, float 5.100000e+01, float 5.200000e+01, float 5.300000e+01, float 5.400000e+01, float 5.500000e+01], [8 x float] [float 5.600000e+01, float 5.700000e+01, float 5.800000e+01, float 5.900000e+01, float 6.000000e+01, float 6.100000e+01, float 6.200000e+01, float 6.300000e+01], [8 x float] [float 6.400000e+01, float 6.500000e+01, float 6.600000e+01, float 6.700000e+01, float 6.800000e+01, float 6.900000e+01, float 7.000000e+01, float 7.100000e+01], [8 x float] [float 7.200000e+01, float 7.300000e+01, float 7.400000e+01, float 7.500000e+01, float 7.600000e+01, float 7.700000e+01, float 7.800000e+01, float 7.900000e+01], [8 x float] [float 8.000000e+01, float 8.100000e+01, float 8.200000e+01, float 8.300000e+01, float 8.400000e+01, float 8.500000e+01, float 8.600000e+01, float 8.700000e+01], [8 x float] [float 8.800000e+01, float 8.900000e+01, float 9.000000e+01, float 9.100000e+01, float 9.200000e+01, float 9.300000e+01, float 9.400000e+01, float 9.500000e+01], [8 x float] [float 9.600000e+01, float 9.700000e+01, float 9.800000e+01, float 9.900000e+01, float 1.000000e+02, float 1.010000e+02, float 1.020000e+02, float 1.030000e+02], [8 x float] [float 1.040000e+02, float 1.050000e+02, float 1.060000e+02, float 1.070000e+02, float 1.080000e+02, float 1.090000e+02, float 1.100000e+02, float 1.110000e+02], [8 x float] [float 1.120000e+02, float 1.130000e+02, float 1.140000e+02, float 1.150000e+02, float 1.160000e+02, float 1.170000e+02, float 1.180000e+02, float 1.190000e+02], [8 x float] [float 1.200000e+02, float 1.210000e+02, float 1.220000e+02, float 1.230000e+02, float 1.240000e+02, float 1.250000e+02, float 1.260000e+02, float 1.270000e+02]]
@B = constant [16 x [8 x float]] [[8 x float] [float 0.000000e+00, float 5.000000e-01, float 1.000000e+00, float 1.500000e+00, float 2.000000e+00, float 2.500000e+00, float 3.000000e+00, float 3.500000e+00], [8 x float] [float 4.000000e+00, float 4.500000e+00, float 5.000000e+00, float 5.500000e+00, float 6.000000e+00, float 6.500000e+00, float 7.000000e+00, float 7.500000e+00], [8 x float] [float 8.000000e+00, float 8.500000e+00, float 9.000000e+00, float 9.500000e+00, float 1.000000e+01, float 1.050000e+01, float 1.100000e+01, float 1.150000e+01], [8 x float] [float 1.200000e+01, float 1.250000e+01, float 1.300000e+01, float 1.350000e+01, float 1.400000e+01, float 1.450000e+01, float 1.500000e+01, float 1.550000e+01], [8 x float] [float 1.600000e+01, float 1.650000e+01, float 1.700000e+01, float 1.750000e+01, float 1.800000e+01, float 1.850000e+01, float 1.900000e+01, float 1.950000e+01], [8 x float] [float 2.000000e+01, float 2.050000e+01, float 2.100000e+01, float 2.150000e+01, float 2.200000e+01, float 2.250000e+01, float 2.300000e+01, float 2.350000e+01], [8 x float] [float 2.400000e+01, float 2.450000e+01, float 2.500000e+01, float 2.550000e+01, float 2.600000e+01, float 2.650000e+01, float 2.700000e+01, float 2.750000e+01], [8 x float] [float 2.800000e+01, float 2.850000e+01, float 2.900000e+01, float 2.950000e+01, float 3.000000e+01, float 3.050000e+01, float 3.100000e+01, float 3.150000e+01], [8 x float] [float 3.200000e+01, float 3.250000e+01, float 3.300000e+01, float 3.350000e+01, float 3.400000e+01, float 3.450000e+01, float 3.500000e+01, float 3.550000e+01], [8 x float] [float 3.600000e+01, float 3.650000e+01, float 3.700000e+01, float 3.750000e+01, float 3.800000e+01, float 3.850000e+01, float 3.900000e+01, float 3.950000e+01], [8 x float] [float 4.000000e+01, float 4.050000e+01, float 4.100000e+01, float 4.150000e+01, float 4.200000e+01, float 4.250000e+01, float 4.300000e+01, float 4.350000e+01], [8 x float] [float 4.400000e+01, float 4.450000e+01, float 4.500000e+01, float 4.550000e+01, float 4.600000e+01, float 4.650000e+01, float 4.700000e+01, float 4.750000e+01], [8 x float] [float 4.800000e+01, float 4.850000e+01, float 4.900000e+01, float 4.950000e+01, float 5.000000e+01, float 5.050000e+01, float 5.100000e+01, float 5.150000e+01], [8 x float] [float 5.200000e+01, float 5.250000e+01, float 5.300000e+01, float 5.350000e+01, float 5.400000e+01, float 5.450000e+01, float 5.500000e+01, float 5.550000e+01], [8 x float] [float 5.600000e+01, float 5.650000e+01, float 5.700000e+01, float 5.750000e+01, float 5.800000e+01, float 5.850000e+01, float 5.900000e+01, float 5.950000e+01], [8 x float] [float 6.000000e+01, float 6.050000e+01, float 6.100000e+01, float 6.150000e+01, float 6.200000e+01, float 6.250000e+01, float 6.300000e+01, float 6.350000e+01]]
@A_PLUS_B = constant [16 x [8 x float]] [[8 x float] [float 0.000000e+00, float 1.500000e+00, float 3.000000e+00, float 4.500000e+00, float 6.000000e+00, float 7.500000e+00, float 9.000000e+00, float 1.050000e+01], [8 x float] [float 1.200000e+01, float 1.350000e+01, float 1.500000e+01, float 1.650000e+01, float 1.800000e+01, float 1.950000e+01, float 2.100000e+01, float 2.250000e+01], [8 x float] [float 2.400000e+01, float 2.550000e+01, float 2.700000e+01, float 2.850000e+01, float 3.000000e+01, float 3.150000e+01, float 3.300000e+01, float 3.450000e+01], [8 x float] [float 3.600000e+01, float 3.750000e+01, float 3.900000e+01, float 4.050000e+01, float 4.200000e+01, float 4.350000e+01, float 4.500000e+01, float 4.650000e+01], [8 x float] [float 4.800000e+01, float 4.950000e+01, float 5.100000e+01, float 5.250000e+01, float 5.400000e+01, float 5.550000e+01, float 5.700000e+01, float 5.850000e+01], [8 x float] [float 6.000000e+01, float 6.150000e+01, float 6.300000e+01, float 6.450000e+01, float 6.600000e+01, float 6.750000e+01, float 6.900000e+01, float 7.050000e+01], [8 x float] [float 7.200000e+01, float 7.350000e+01, float 7.500000e+01, float 7.650000e+01, float 7.800000e+01, float 7.950000e+01, float 8.100000e+01, float 8.250000e+01], [8 x float] [float 8.400000e+01, float 8.550000e+01, float 8.700000e+01, float 8.850000e+01, float 9.000000e+01, float 9.150000e+01, float 9.300000e+01, float 9.450000e+01], [8 x float] [float 9.600000e+01, float 9.750000e+01, float 9.900000e+01, float 1.005000e+02, float 1.020000e+02, float 1.035000e+02, float 1.050000e+02, float 1.065000e+02], [8 x float] [float 1.080000e+02, float 1.095000e+02, float 1.110000e+02, float 1.125000e+02, float 1.140000e+02, float 1.155000e+02, float 1.170000e+02, float 1.185000e+02], [8 x float] [float 1.200000e+02, float 1.215000e+02, float 1.230000e+02, float 1.245000e+02, float 1.260000e+02, float 1.275000e+02, float 1.290000e+02, float 1.305000e+02], [8 x float] [float 1.320000e+02, float 1.335000e+02, float 1.350000e+02, float 1.365000e+02, float 1.380000e+02, float 1.395000e+02, float 1.410000e+02, float 1.425000e+02], [8 x float] [float 1.440000e+02, float 1.455000e+02, float 1.470000e+02, float 1.485000e+02, float 1.500000e+02, float 1.515000e+02, float 1.530000e+02, float 1.545000e+02], [8 x float] [float 1.560000e+02, float 1.575000e+02, float 1.590000e+02, float 1.605000e+02, float 1.620000e+02, float 1.635000e+02, float 1.650000e+02, float 1.665000e+02], [8 x float] [float 1.680000e+02, float 1.695000e+02, float 1.710000e+02, float 1.725000e+02, float 1.740000e+02, float 1.755000e+02, float 1.770000e+02, float 1.785000e+02], [8 x float] [float 1.800000e+02, float 1.815000e+02, float 1.830000e+02, float 1.845000e+02, float 1.860000e+02, float 1.875000e+02, float 1.890000e+02, float 1.905000e+02]]

declare i8* @malloc(i64)

declare void @free(i8*)

define void @addf(float* %0, float* %1) {
  %3 = insertvalue { float*, float*, i32, [2 x i32], [2 x i32] } undef, float* %0, 0
  %4 = insertvalue { float*, float*, i32, [2 x i32], [2 x i32] } %3, float* %0, 1
  %5 = insertvalue { float*, float*, i32, [2 x i32], [2 x i32] } %4, i32 0, 2
  %6 = insertvalue { float*, float*, i32, [2 x i32], [2 x i32] } %5, i32 16, 3, 0
  %7 = insertvalue { float*, float*, i32, [2 x i32], [2 x i32] } %6, i32 8, 4, 0
  %8 = insertvalue { float*, float*, i32, [2 x i32], [2 x i32] } %7, i32 8, 3, 1
  %9 = insertvalue { float*, float*, i32, [2 x i32], [2 x i32] } %8, i32 1, 4, 1
  %10 = insertvalue { float*, float*, i32, [2 x i32], [2 x i32] } undef, float* %1, 0
  %11 = insertvalue { float*, float*, i32, [2 x i32], [2 x i32] } %10, float* %1, 1
  %12 = insertvalue { float*, float*, i32, [2 x i32], [2 x i32] } %11, i32 0, 2
  %13 = insertvalue { float*, float*, i32, [2 x i32], [2 x i32] } %12, i32 16, 3, 0
  %14 = insertvalue { float*, float*, i32, [2 x i32], [2 x i32] } %13, i32 8, 4, 0
  %15 = insertvalue { float*, float*, i32, [2 x i32], [2 x i32] } %14, i32 8, 3, 1
  %16 = insertvalue { float*, float*, i32, [2 x i32], [2 x i32] } %15, i32 1, 4, 1
  br label %17

17:                                               ; preds = %37, %2
  %18 = phi i32 [ %38, %37 ], [ 0, %2 ]
  %19 = icmp slt i32 %18, 16
  br i1 %19, label %20, label %39

20:                                               ; preds = %23, %17
  %21 = phi i32 [ %36, %23 ], [ 0, %17 ]
  %22 = icmp slt i32 %21, 8
  br i1 %22, label %23, label %37

23:                                               ; preds = %20
  %24 = mul i32 %18, 8
  %25 = add i32 %24, %21
  %26 = getelementptr float, float* %1, i32 %25
  %27 = load float, float* %26, align 4
  %28 = mul i32 %18, 8
  %29 = add i32 %28, %21
  %30 = getelementptr float, float* %0, i32 %29
  %31 = load float, float* %30, align 4
  %32 = fadd float %31, %27
  %33 = mul i32 %18, 8
  %34 = add i32 %33, %21
  %35 = getelementptr float, float* %0, i32 %34
  store float %32, float* %35, align 4
  %36 = add i32 %21, 1
  br label %20

37:                                               ; preds = %20
  %38 = add i32 %18, 1
  br label %17

39:                                               ; preds = %17
  ret void
}

define i32 @memref_diff(float* %0, float* %1, float %2) {
  %4 = insertvalue { float*, float*, i32, [2 x i32], [2 x i32] } undef, float* %0, 0
  %5 = insertvalue { float*, float*, i32, [2 x i32], [2 x i32] } %4, float* %0, 1
  %6 = insertvalue { float*, float*, i32, [2 x i32], [2 x i32] } %5, i32 0, 2
  %7 = insertvalue { float*, float*, i32, [2 x i32], [2 x i32] } %6, i32 16, 3, 0
  %8 = insertvalue { float*, float*, i32, [2 x i32], [2 x i32] } %7, i32 8, 4, 0
  %9 = insertvalue { float*, float*, i32, [2 x i32], [2 x i32] } %8, i32 8, 3, 1
  %10 = insertvalue { float*, float*, i32, [2 x i32], [2 x i32] } %9, i32 1, 4, 1
  %11 = insertvalue { float*, float*, i32, [2 x i32], [2 x i32] } undef, float* %1, 0
  %12 = insertvalue { float*, float*, i32, [2 x i32], [2 x i32] } %11, float* %1, 1
  %13 = insertvalue { float*, float*, i32, [2 x i32], [2 x i32] } %12, i32 0, 2
  %14 = insertvalue { float*, float*, i32, [2 x i32], [2 x i32] } %13, i32 16, 3, 0
  %15 = insertvalue { float*, float*, i32, [2 x i32], [2 x i32] } %14, i32 8, 4, 0
  %16 = insertvalue { float*, float*, i32, [2 x i32], [2 x i32] } %15, i32 8, 3, 1
  %17 = insertvalue { float*, float*, i32, [2 x i32], [2 x i32] } %16, i32 1, 4, 1
  br label %18

18:                                               ; preds = %41, %3
  %19 = phi i32 [ %43, %41 ], [ 0, %3 ]
  %20 = phi i32 [ %42, %41 ], [ 0, %3 ]
  %21 = icmp slt i32 %19, 16
  br i1 %21, label %22, label %44

22:                                               ; preds = %26, %18
  %23 = phi i32 [ %40, %26 ], [ 0, %18 ]
  %24 = phi i32 [ %39, %26 ], [ 0, %18 ]
  %25 = icmp slt i32 %23, 8
  br i1 %25, label %26, label %41

26:                                               ; preds = %22
  %27 = mul i32 %19, 8
  %28 = add i32 %27, %23
  %29 = getelementptr float, float* %0, i32 %28
  %30 = load float, float* %29, align 4
  %31 = mul i32 %19, 8
  %32 = add i32 %31, %23
  %33 = getelementptr float, float* %1, i32 %32
  %34 = load float, float* %33, align 4
  %35 = fsub float %30, %34
  %36 = call float @llvm.fabs.f32(float %35)
  %37 = fcmp oge float %36, %2
  %38 = zext i1 %37 to i32
  %39 = add i32 %38, %24
  %40 = add i32 %23, 1
  br label %22

41:                                               ; preds = %22
  %42 = add i32 %24, %20
  %43 = add i32 %19, 1
  br label %18

44:                                               ; preds = %18
  ret i32 %20
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.fabs.f32(float) #0

attributes #0 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
