; ModuleID = '/home/david/src/c-semantics/tests/gcc-torture/921019-1.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [2 x i8] c"X\00", align 1
@foo = global [1 x i8*] [i8* getelementptr inbounds ([2 x i8]* @.str, i32 0, i32 0)], align 8

define i32 @main() noreturn nounwind uwtable {
entry:
  %0 = load i8** getelementptr inbounds ([1 x i8*]* @foo, i64 0, i64 0), align 8, !tbaa !0
  %1 = load i8* %0, align 1, !tbaa !1
  %cmp = icmp eq i8 %1, 88
  br i1 %cmp, label %if.end, label %if.then

if.then:                                          ; preds = %entry
  tail call void @abort() noreturn nounwind
  unreachable

if.end:                                           ; preds = %entry
  tail call void @exit(i32 0) noreturn nounwind
  unreachable
}

declare void @abort() noreturn nounwind

declare void @exit(i32) noreturn nounwind

!0 = metadata !{metadata !"any pointer", metadata !1}
!1 = metadata !{metadata !"omnipotent char", metadata !2}
!2 = metadata !{metadata !"Simple C/C++ TBAA", null}
