; ModuleID = '/home/david/src/c-semantics/tests/llvm-unit/2002-05-02-CastTest2.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [11 x i8] c"us2  = %u\0A\00", align 1

define i32 @main(i32 %argc, i8** %argv) nounwind uwtable {
entry:
  %retval = alloca i32, align 4
  %argc.addr = alloca i32, align 4
  %argv.addr = alloca i8**, align 8
  %s1 = alloca i16, align 2
  %us2 = alloca i16, align 2
  store i32 0, i32* %retval
  store i32 %argc, i32* %argc.addr, align 4
  store i8** %argv, i8*** %argv.addr, align 8
  %0 = load i32* %argc.addr, align 4
  %cmp = icmp sgt i32 %0, 120
  br i1 %cmp, label %cond.true, label %cond.false

cond.true:                                        ; preds = %entry
  %1 = load i8*** %argv.addr, align 8
  %arrayidx = getelementptr inbounds i8** %1, i64 1
  %2 = load i8** %arrayidx, align 8
  %call = call i32 @atoi(i8* %2) nounwind readonly
  br label %cond.end

cond.false:                                       ; preds = %entry
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i32 [ %call, %cond.true ], [ -769, %cond.false ]
  %conv = trunc i32 %cond to i16
  store i16 %conv, i16* %s1, align 2
  %3 = load i16* %s1, align 2
  store i16 %3, i16* %us2, align 2
  %4 = load i16* %us2, align 2
  %conv1 = zext i16 %4 to i32
  %call2 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([11 x i8]* @.str, i32 0, i32 0), i32 %conv1)
  ret i32 0
}

declare i32 @atoi(i8*) nounwind readonly

declare i32 @printf(i8*, ...)
