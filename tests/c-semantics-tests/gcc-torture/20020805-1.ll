; ModuleID = '/home/david/src/c-semantics/tests/gcc-torture/20020805-1.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@n = global i32 1, align 4

define void @check(i32 %m) nounwind uwtable {
entry:
  %m.addr = alloca i32, align 4
  store i32 %m, i32* %m.addr, align 4
  %0 = load i32* %m.addr, align 4
  %cmp = icmp ne i32 %0, -1
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  call void @abort() noreturn
  unreachable

if.end:                                           ; preds = %entry
  ret void
}

declare void @abort() noreturn

define i32 @main() nounwind uwtable {
entry:
  %retval = alloca i32, align 4
  %m = alloca i32, align 4
  store i32 0, i32* %retval
  %0 = load i32* @n, align 4
  %sub = sub i32 2, %0
  %or = or i32 1, %sub
  %1 = load i32* @n, align 4
  %sub1 = sub i32 0, %1
  %or2 = or i32 %or, %sub1
  store i32 %or2, i32* %m, align 4
  %2 = load i32* %m, align 4
  call void @check(i32 %2)
  call void @exit(i32 0) noreturn
  unreachable

return:                                           ; No predecessors!
  %3 = load i32* %retval
  ret i32 %3
}

declare void @exit(i32) noreturn
