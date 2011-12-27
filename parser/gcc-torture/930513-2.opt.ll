; ModuleID = '/home/grosu/celliso2/c-semantics/tests/gcc-torture/930513-2.ll'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-unknown-linux-gnu"

@eq.i = internal unnamed_addr global i32 0, align 4

define void @sub3(i32* nocapture %i) nounwind uwtable readnone {
entry:
  ret void
}

define void @eq(i32 %a, i32 %b) nounwind uwtable {
entry:
  %tmp1 = load i32* @eq.i, align 4
  %cmp = icmp eq i32 %tmp1, %a
  br i1 %cmp, label %if.end, label %if.then

if.then:                                          ; preds = %entry
  tail call void @abort() noreturn nounwind
  unreachable

if.end:                                           ; preds = %entry
  %inc = add nsw i32 %tmp1, 1
  store i32 %inc, i32* @eq.i, align 4
  ret void
}

declare void @abort() noreturn

define i32 @main() noreturn nounwind uwtable {
entry:
  %eq.i.promoted = load i32* @eq.i, align 4
  br label %for.cond

for.cond:                                         ; preds = %eq.exit, %entry
  %0 = phi i32 [ 0, %entry ], [ %inc, %eq.exit ]
  %inc.i1 = add i32 %eq.i.promoted, %0
  %cmp = icmp slt i32 %0, 4
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %cmp.i = icmp eq i32 %eq.i.promoted, 0
  br i1 %cmp.i, label %eq.exit, label %if.then.i

if.then.i:                                        ; preds = %for.body
  store i32 %inc.i1, i32* @eq.i, align 4
  tail call void @abort() noreturn nounwind
  unreachable

eq.exit:                                          ; preds = %for.body
  %inc = add nsw i32 %0, 1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  store i32 %inc.i1, i32* @eq.i, align 4
  tail call void @exit(i32 0) noreturn nounwind
  unreachable
}

declare void @exit(i32) noreturn
