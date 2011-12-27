; ModuleID = '/home/grosu/celliso2/c-semantics/tests/gcc-torture/20071216-1.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-unknown-linux-gnu"

@x = internal global i32 0, align 4

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

define i32 @bar() nounwind uwtable noinline {
entry:
  %tmp = load i32* @x, align 4
  ret i32 %tmp
}

define i32 @foo() nounwind uwtable {
entry:
  %retval = alloca i32, align 4
  %b = alloca i64, align 8
  %call = call i32 @bar()
  %conv = sext i32 %call to i64
  store i64 %conv, i64* %b, align 8
  %tmp = load i64* %b, align 8
  %cmp = icmp ult i64 %tmp, -4095
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %tmp2 = load i64* %b, align 8
  %conv3 = trunc i64 %tmp2 to i32
  store i32 %conv3, i32* %retval
  br label %return

if.end:                                           ; preds = %entry
  %tmp4 = load i64* %b, align 8
  %sub = sub nsw i64 0, %tmp4
  %cmp5 = icmp ne i64 %sub, 38
  br i1 %cmp5, label %if.then7, label %if.end8

if.then7:                                         ; preds = %if.end
  store i64 -2, i64* %b, align 8
  br label %if.end8

if.end8:                                          ; preds = %if.then7, %if.end
  %tmp9 = load i64* %b, align 8
  %add = add nsw i64 %tmp9, 1
  %conv10 = trunc i64 %add to i32
  store i32 %conv10, i32* %retval
  br label %return

return:                                           ; preds = %if.end8, %if.then
  %0 = load i32* %retval
  ret i32 %0
}

define i32 @main() nounwind uwtable {
entry:
  %retval = alloca i32, align 4
  store i32 0, i32* %retval
  store i32 26, i32* @x, align 4
  %call = call i32 @foo()
  %cmp = icmp ne i32 %call, 26
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  call void @abort() noreturn nounwind
  unreachable

if.end:                                           ; preds = %entry
  store i32 -39, i32* @x, align 4
  %call1 = call i32 @foo()
  %cmp2 = icmp ne i32 %call1, -1
  br i1 %cmp2, label %if.then3, label %if.end4

if.then3:                                         ; preds = %if.end
  call void @abort() noreturn nounwind
  unreachable

if.end4:                                          ; preds = %if.end
  store i32 -38, i32* @x, align 4
  %call5 = call i32 @foo()
  %cmp6 = icmp ne i32 %call5, -37
  br i1 %cmp6, label %if.then7, label %if.end8

if.then7:                                         ; preds = %if.end4
  call void @abort() noreturn nounwind
  unreachable

if.end8:                                          ; preds = %if.end4
  ret i32 0
}

declare void @abort() noreturn nounwind
