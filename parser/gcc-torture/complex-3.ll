; ModuleID = '/home/grosu/celliso2/c-semantics/tests/gcc-torture/complex-3.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-unknown-linux-gnu"

%struct.complex = type { float, float }

define i32 @gnu_dev_major(i64 %__dev) nounwind uwtable inlinehint {
entry:
  %__dev.addr = alloca i64, align 8
  store i64 %__dev, i64* %__dev.addr, align 8
  %tmp = load i64* %__dev.addr, align 8
  %shr = lshr i64 %tmp, 8
  %and = and i64 %shr, 4095
  %tmp1 = load i64* %__dev.addr, align 8
  %shr2 = lshr i64 %tmp1, 32
  %conv = trunc i64 %shr2 to i32
  %and3 = and i32 %conv, -4096
  %conv4 = zext i32 %and3 to i64
  %or = or i64 %and, %conv4
  %conv5 = trunc i64 %or to i32
  ret i32 %conv5
}

define i32 @gnu_dev_minor(i64 %__dev) nounwind uwtable inlinehint {
entry:
  %__dev.addr = alloca i64, align 8
  store i64 %__dev, i64* %__dev.addr, align 8
  %tmp = load i64* %__dev.addr, align 8
  %and = and i64 %tmp, 255
  %tmp1 = load i64* %__dev.addr, align 8
  %shr = lshr i64 %tmp1, 12
  %conv = trunc i64 %shr to i32
  %and2 = and i32 %conv, -256
  %conv3 = zext i32 %and2 to i64
  %or = or i64 %and, %conv3
  %conv4 = trunc i64 %or to i32
  ret i32 %conv4
}

define i64 @gnu_dev_makedev(i32 %__major, i32 %__minor) nounwind uwtable inlinehint {
entry:
  %__major.addr = alloca i32, align 4
  %__minor.addr = alloca i32, align 4
  store i32 %__major, i32* %__major.addr, align 4
  store i32 %__minor, i32* %__minor.addr, align 4
  %tmp = load i32* %__minor.addr, align 4
  %and = and i32 %tmp, 255
  %tmp1 = load i32* %__major.addr, align 4
  %and2 = and i32 %tmp1, 4095
  %shl = shl i32 %and2, 8
  %or = or i32 %and, %shl
  %conv = zext i32 %or to i64
  %tmp3 = load i32* %__minor.addr, align 4
  %and4 = and i32 %tmp3, -256
  %conv5 = zext i32 %and4 to i64
  %shl6 = shl i64 %conv5, 12
  %or7 = or i64 %conv, %shl6
  %tmp8 = load i32* %__major.addr, align 4
  %and9 = and i32 %tmp8, -4096
  %conv10 = zext i32 %and9 to i64
  %shl11 = shl i64 %conv10, 32
  %or12 = or i64 %or7, %shl11
  ret i64 %or12
}

define <2 x float> @f(float %a, float %b) nounwind uwtable {
entry:
  %retval = alloca %struct.complex, align 4
  %a.addr = alloca float, align 4
  %b.addr = alloca float, align 4
  %c = alloca %struct.complex, align 4
  store float %a, float* %a.addr, align 4
  store float %b, float* %b.addr, align 4
  %tmp = load float* %a.addr, align 4
  %r = getelementptr inbounds %struct.complex* %c, i32 0, i32 0
  store float %tmp, float* %r, align 4
  %tmp1 = load float* %b.addr, align 4
  %i = getelementptr inbounds %struct.complex* %c, i32 0, i32 1
  store float %tmp1, float* %i, align 4
  %tmp2 = bitcast %struct.complex* %retval to i8*
  %tmp3 = bitcast %struct.complex* %c to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %tmp2, i8* %tmp3, i64 8, i32 4, i1 false)
  %0 = bitcast %struct.complex* %retval to <2 x float>*
  %1 = load <2 x float>* %0, align 1
  ret <2 x float> %1
}

declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture, i64, i32, i1) nounwind

define i32 @main() nounwind uwtable {
entry:
  %retval = alloca i32, align 4
  %z = alloca %struct.complex, align 4
  store i32 0, i32* %retval
  %call = call <2 x float> @f(float 1.000000e+00, float 0.000000e+00)
  %0 = bitcast %struct.complex* %z to <2 x float>*
  store <2 x float> %call, <2 x float>* %0
  %r = getelementptr inbounds %struct.complex* %z, i32 0, i32 0
  %tmp = load float* %r, align 4
  %conv = fpext float %tmp to double
  %cmp = fcmp une double %conv, 1.000000e+00
  br i1 %cmp, label %if.then, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %entry
  %i = getelementptr inbounds %struct.complex* %z, i32 0, i32 1
  %tmp2 = load float* %i, align 4
  %conv3 = fpext float %tmp2 to double
  %cmp4 = fcmp une double %conv3, 0.000000e+00
  br i1 %cmp4, label %if.then, label %if.end

if.then:                                          ; preds = %lor.lhs.false, %entry
  call void @abort() noreturn nounwind
  unreachable

if.end:                                           ; preds = %lor.lhs.false
  call void @exit(i32 0) noreturn nounwind
  unreachable

return:                                           ; No predecessors!
  %1 = load i32* %retval
  ret i32 %1
}

declare void @abort() noreturn nounwind

declare void @exit(i32) noreturn nounwind
