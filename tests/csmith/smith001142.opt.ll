; ModuleID = '/home/grosu/celliso2/c-semantics/tests/csmith/smith001142.ll'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-unknown-linux-gnu"

@g_4 = global i32 -2, align 4
@.str = private unnamed_addr constant [19 x i8] c"checksum g_4 = %d\0A\00", align 1
@__undefined = common global i64 0, align 8

define i64 @func_1() nounwind uwtable {
entry:
  %tmp2 = load i32* @g_4, align 4
  %and = and i32 %tmp2, 1614784348
  store i32 %and, i32* @g_4, align 4
  %conv1 = zext i32 %and to i64
  ret i64 %conv1
}

define i32 @main(i32 %argc, i8** nocapture %argv) nounwind uwtable {
entry:
  %tmp2.i = load i32* @g_4, align 4
  %and.i = and i32 %tmp2.i, 1614784348
  store i32 %and.i, i32* @g_4, align 4
  %call1 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([19 x i8]* @.str, i64 0, i64 0), i32 %and.i) nounwind
  ret i32 0
}

declare i32 @printf(i8* nocapture, ...) nounwind