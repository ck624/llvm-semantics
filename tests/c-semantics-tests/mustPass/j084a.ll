; ModuleID = '/home/david/src/c-semantics/tests/mustPass/j084a.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() nounwind uwtable {
entry:
  %retval = alloca i32, align 4
  %a = alloca [1 x i32], align 4
  store i32 0, i32* %retval
  %0 = bitcast [1 x i32]* %a to i8*
  call void @llvm.memset.p0i8.i64(i8* %0, i8 0, i64 4, i32 4, i1 false)
  %arrayidx = getelementptr inbounds [1 x i32]* %a, i32 0, i64 0
  %1 = load i32* %arrayidx, align 4
  ret i32 %1
}

declare void @llvm.memset.p0i8.i64(i8* nocapture, i8, i64, i32, i1) nounwind
