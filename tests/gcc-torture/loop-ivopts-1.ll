; ModuleID = '/home/grosu/celliso2/c-semantics/tests/gcc-torture/loop-ivopts-1.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-unknown-linux-gnu"

@foo.t16 = internal global [16 x float] [float 1.000000e+00, float 2.000000e+00, float 3.000000e+00, float 4.000000e+00, float 5.000000e+00, float 6.000000e+00, float 7.000000e+00, float 8.000000e+00, float 9.000000e+00, float 1.000000e+01, float 1.100000e+01, float 1.200000e+01, float 1.300000e+01, float 1.400000e+01, float 1.500000e+01, float 1.600000e+01], align 16
@foo.tmp = internal global [4 x float] zeroinitializer, align 16

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

define i32 @main() nounwind uwtable {
entry:
  %retval = alloca i32, align 4
  %x = alloca [4 x float], align 16
  store i32 0, i32* %retval
  %arraydecay = getelementptr inbounds [4 x float]* %x, i32 0, i32 0
  call void @foo(float* %arraydecay)
  ret i32 0
}

define void @foo(float* %x) nounwind uwtable {
entry:
  %x.addr = alloca float*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %k = alloca i32, align 4
  %temp = alloca float, align 4
  store float* %x, float** %x.addr, align 8
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc22, %entry
  %tmp = load i32* %i, align 4
  %cmp = icmp slt i32 %tmp, 4
  br i1 %cmp, label %for.body, label %for.end25

for.body:                                         ; preds = %for.cond
  %tmp1 = load i32* %i, align 4
  %sub = sub nsw i32 3, %tmp1
  store i32 %sub, i32* %k, align 4
  %tmp2 = load i32* %k, align 4
  %mul = mul nsw i32 5, %tmp2
  %idxprom = sext i32 %mul to i64
  %arrayidx = getelementptr inbounds [16 x float]* @foo.t16, i32 0, i64 %idxprom
  %tmp3 = load float* %arrayidx, align 4
  store float %tmp3, float* %temp, align 4
  %tmp4 = load i32* %k, align 4
  %add = add nsw i32 %tmp4, 1
  store i32 %add, i32* %j, align 4
  br label %for.cond5

for.cond5:                                        ; preds = %for.inc, %for.body
  %tmp6 = load i32* %j, align 4
  %cmp7 = icmp slt i32 %tmp6, 4
  br i1 %cmp7, label %for.body8, label %for.end

for.body8:                                        ; preds = %for.cond5
  %tmp9 = load i32* %k, align 4
  %tmp10 = load i32* %j, align 4
  %mul11 = mul nsw i32 %tmp10, 4
  %add12 = add nsw i32 %tmp9, %mul11
  %idxprom13 = sext i32 %add12 to i64
  %arrayidx14 = getelementptr inbounds [16 x float]* @foo.t16, i32 0, i64 %idxprom13
  %tmp15 = load float* %arrayidx14, align 4
  %tmp16 = load float* %temp, align 4
  %mul17 = fmul float %tmp15, %tmp16
  %tmp18 = load i32* %k, align 4
  %idxprom19 = sext i32 %tmp18 to i64
  %arrayidx20 = getelementptr inbounds [4 x float]* @foo.tmp, i32 0, i64 %idxprom19
  store float %mul17, float* %arrayidx20, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body8
  %tmp21 = load i32* %j, align 4
  %inc = add nsw i32 %tmp21, 1
  store i32 %inc, i32* %j, align 4
  br label %for.cond5

for.end:                                          ; preds = %for.cond5
  br label %for.inc22

for.inc22:                                        ; preds = %for.end
  %tmp23 = load i32* %i, align 4
  %inc24 = add nsw i32 %tmp23, 1
  store i32 %inc24, i32* %i, align 4
  br label %for.cond

for.end25:                                        ; preds = %for.cond
  %tmp26 = load float* getelementptr inbounds ([4 x float]* @foo.tmp, i32 0, i64 0), align 4
  %tmp27 = load float** %x.addr, align 8
  %arrayidx28 = getelementptr inbounds float* %tmp27, i64 0
  store float %tmp26, float* %arrayidx28
  %tmp29 = load float* getelementptr inbounds ([4 x float]* @foo.tmp, i32 0, i64 1), align 4
  %tmp30 = load float** %x.addr, align 8
  %arrayidx31 = getelementptr inbounds float* %tmp30, i64 1
  store float %tmp29, float* %arrayidx31
  %tmp32 = load float* getelementptr inbounds ([4 x float]* @foo.tmp, i32 0, i64 2), align 4
  %tmp33 = load float** %x.addr, align 8
  %arrayidx34 = getelementptr inbounds float* %tmp33, i64 2
  store float %tmp32, float* %arrayidx34
  %tmp35 = load float* getelementptr inbounds ([4 x float]* @foo.tmp, i32 0, i64 3), align 4
  %tmp36 = load float** %x.addr, align 8
  %arrayidx37 = getelementptr inbounds float* %tmp36, i64 3
  store float %tmp35, float* %arrayidx37
  ret void
}