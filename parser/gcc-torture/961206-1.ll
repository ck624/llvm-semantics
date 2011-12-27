; ModuleID = '/home/grosu/celliso2/c-semantics/tests/gcc-torture/961206-1.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-unknown-linux-gnu"

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

define i32 @sub1(i64 %i) nounwind uwtable {
entry:
  %retval = alloca i32, align 4
  %i.addr = alloca i64, align 8
  store i64 %i, i64* %i.addr, align 8
  %tmp = load i64* %i.addr, align 8
  %cmp = icmp ult i64 %tmp, 2147483648
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  store i32 1, i32* %retval
  br label %return

if.else:                                          ; preds = %entry
  store i32 0, i32* %retval
  br label %return

return:                                           ; preds = %if.else, %if.then
  %0 = load i32* %retval
  ret i32 %0
}

define i32 @sub2(i64 %i) nounwind uwtable {
entry:
  %retval = alloca i32, align 4
  %i.addr = alloca i64, align 8
  store i64 %i, i64* %i.addr, align 8
  %tmp = load i64* %i.addr, align 8
  %cmp = icmp ule i64 %tmp, 2147483647
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  store i32 1, i32* %retval
  br label %return

if.else:                                          ; preds = %entry
  store i32 0, i32* %retval
  br label %return

return:                                           ; preds = %if.else, %if.then
  %0 = load i32* %retval
  ret i32 %0
}

define i32 @sub3(i64 %i) nounwind uwtable {
entry:
  %retval = alloca i32, align 4
  %i.addr = alloca i64, align 8
  store i64 %i, i64* %i.addr, align 8
  %tmp = load i64* %i.addr, align 8
  %cmp = icmp uge i64 %tmp, 2147483648
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  store i32 0, i32* %retval
  br label %return

if.else:                                          ; preds = %entry
  store i32 1, i32* %retval
  br label %return

return:                                           ; preds = %if.else, %if.then
  %0 = load i32* %retval
  ret i32 %0
}

define i32 @sub4(i64 %i) nounwind uwtable {
entry:
  %retval = alloca i32, align 4
  %i.addr = alloca i64, align 8
  store i64 %i, i64* %i.addr, align 8
  %tmp = load i64* %i.addr, align 8
  %cmp = icmp ugt i64 %tmp, 2147483647
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  store i32 0, i32* %retval
  br label %return

if.else:                                          ; preds = %entry
  store i32 1, i32* %retval
  br label %return

return:                                           ; preds = %if.else, %if.then
  %0 = load i32* %retval
  ret i32 %0
}

define i32 @main() nounwind uwtable {
entry:
  %retval = alloca i32, align 4
  store i32 0, i32* %retval
  %call = call i32 @sub1(i64 2147483648)
  %tobool = icmp ne i32 %call, 0
  br i1 %tobool, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  call void @abort() noreturn nounwind
  unreachable

if.end:                                           ; preds = %entry
  %call1 = call i32 @sub2(i64 2147483648)
  %tobool2 = icmp ne i32 %call1, 0
  br i1 %tobool2, label %if.then3, label %if.end4

if.then3:                                         ; preds = %if.end
  call void @abort() noreturn nounwind
  unreachable

if.end4:                                          ; preds = %if.end
  %call5 = call i32 @sub3(i64 2147483648)
  %tobool6 = icmp ne i32 %call5, 0
  br i1 %tobool6, label %if.then7, label %if.end8

if.then7:                                         ; preds = %if.end4
  call void @abort() noreturn nounwind
  unreachable

if.end8:                                          ; preds = %if.end4
  %call9 = call i32 @sub4(i64 2147483648)
  %tobool10 = icmp ne i32 %call9, 0
  br i1 %tobool10, label %if.then11, label %if.end12

if.then11:                                        ; preds = %if.end8
  call void @abort() noreturn nounwind
  unreachable

if.end12:                                         ; preds = %if.end8
  call void @exit(i32 0) noreturn nounwind
  unreachable

return:                                           ; No predecessors!
  %0 = load i32* %retval
  ret i32 %0
}

declare void @abort() noreturn nounwind

declare void @exit(i32) noreturn nounwind
