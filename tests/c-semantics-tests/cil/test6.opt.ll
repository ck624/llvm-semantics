; ModuleID = '/home/david/src/c-semantics/tests/cil/test6.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@a = common global [20 x i32] zeroinitializer, align 16
@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1

define i32 @f() nounwind uwtable {
entry:
  store i32 33, i32* getelementptr inbounds ([20 x i32]* @a, i64 0, i64 0), align 16, !tbaa !0
  store i32 19, i32* getelementptr inbounds ([20 x i32]* @a, i64 0, i64 2), align 8, !tbaa !0
  ret i32 19
}

define i32 @main(i32 %argc, i8** nocapture %argv) nounwind uwtable {
entry:
  store i32 33, i32* getelementptr inbounds ([20 x i32]* @a, i64 0, i64 0), align 16, !tbaa !0
  store i32 19, i32* getelementptr inbounds ([20 x i32]* @a, i64 0, i64 2), align 8, !tbaa !0
  %call1 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i64 0, i64 0), i32 19) nounwind
  ret i32 0
}

declare i32 @printf(i8* nocapture, ...) nounwind

!0 = metadata !{metadata !"int", metadata !1}
!1 = metadata !{metadata !"omnipotent char", metadata !2}
!2 = metadata !{metadata !"Simple C/C++ TBAA", null}
