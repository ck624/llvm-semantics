; ModuleID = '/home/david/src/c-semantics/tests/shouldPass/j058d.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@x = common global i32 0, align 4
@a1 = global i32* @x, align 8
@a = global i32** @a1, align 8
@p = global i32* null, align 8
@y = common global i32 0, align 4

define i32 @main() nounwind uwtable readonly {
entry:
  %0 = load i32** @p, align 8, !tbaa !0
  %cmp = icmp ne i32* %0, null
  %conv = zext i1 %cmp to i32
  ret i32 %conv
}

!0 = metadata !{metadata !"any pointer", metadata !1}
!1 = metadata !{metadata !"omnipotent char", metadata !2}
!2 = metadata !{metadata !"Simple C/C++ TBAA", null}
