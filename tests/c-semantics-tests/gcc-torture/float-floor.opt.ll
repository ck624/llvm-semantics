; ModuleID = '/home/david/src/c-semantics/tests/gcc-torture/float-floor.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@d = global double 0x408FFFFFF0000000, align 8

define i32 @main() nounwind uwtable {
entry:
  %0 = load double* @d, align 8, !tbaa !0
  %call = tail call double @floor(double %0) nounwind
  %1 = load double* @d, align 8, !tbaa !0
  %call1 = tail call double @floor(double %1) nounwind
  %conv2 = fptosi double %call to i32
  %cmp = icmp eq i32 %conv2, 1023
  br i1 %cmp, label %lor.lhs.false, label %if.then

lor.lhs.false:                                    ; preds = %entry
  %conv = fptrunc double %call1 to float
  %conv4 = fptosi float %conv to i32
  %cmp5 = icmp eq i32 %conv4, 1023
  br i1 %cmp5, label %if.end, label %if.then

if.then:                                          ; preds = %lor.lhs.false, %entry
  tail call void @abort() noreturn nounwind
  unreachable

if.end:                                           ; preds = %lor.lhs.false
  ret i32 0
}

declare double @floor(double)

declare void @abort() noreturn nounwind

!0 = metadata !{metadata !"double", metadata !1}
!1 = metadata !{metadata !"omnipotent char", metadata !2}
!2 = metadata !{metadata !"Simple C/C++ TBAA", null}
