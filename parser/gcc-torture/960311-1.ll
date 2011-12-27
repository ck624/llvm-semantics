; ModuleID = '/home/grosu/celliso2/c-semantics/tests/gcc-torture/960311-1.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-unknown-linux-gnu"

@count = common global i32 0, align 4

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

define void @a1() nounwind uwtable {
entry:
  %tmp = load i32* @count, align 4
  %inc = add nsw i32 %tmp, 1
  store i32 %inc, i32* @count, align 4
  ret void
}

define void @b(i8 zeroext %data) nounwind uwtable {
entry:
  %data.addr = alloca i8, align 1
  store i8 %data, i8* %data.addr, align 1
  %tmp = load i8* %data.addr, align 1
  %conv = zext i8 %tmp to i32
  %and = and i32 %conv, 128
  %tobool = icmp ne i32 %and, 0
  br i1 %tobool, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  call void @a1()
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  %tmp1 = load i8* %data.addr, align 1
  %conv2 = zext i8 %tmp1 to i32
  %shl = shl i32 %conv2, 1
  %conv3 = trunc i32 %shl to i8
  store i8 %conv3, i8* %data.addr, align 1
  %tmp4 = load i8* %data.addr, align 1
  %conv5 = zext i8 %tmp4 to i32
  %and6 = and i32 %conv5, 128
  %tobool7 = icmp ne i32 %and6, 0
  br i1 %tobool7, label %if.then8, label %if.end9

if.then8:                                         ; preds = %if.end
  call void @a1()
  br label %if.end9

if.end9:                                          ; preds = %if.then8, %if.end
  %tmp10 = load i8* %data.addr, align 1
  %conv11 = zext i8 %tmp10 to i32
  %shl12 = shl i32 %conv11, 1
  %conv13 = trunc i32 %shl12 to i8
  store i8 %conv13, i8* %data.addr, align 1
  %tmp14 = load i8* %data.addr, align 1
  %conv15 = zext i8 %tmp14 to i32
  %and16 = and i32 %conv15, 128
  %tobool17 = icmp ne i32 %and16, 0
  br i1 %tobool17, label %if.then18, label %if.end19

if.then18:                                        ; preds = %if.end9
  call void @a1()
  br label %if.end19

if.end19:                                         ; preds = %if.then18, %if.end9
  ret void
}

define i32 @main() nounwind uwtable {
entry:
  %retval = alloca i32, align 4
  store i32 0, i32* %retval
  store i32 0, i32* @count, align 4
  call void @b(i8 zeroext 0)
  %tmp = load i32* @count, align 4
  %cmp = icmp ne i32 %tmp, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  call void @abort() noreturn nounwind
  unreachable

if.end:                                           ; preds = %entry
  store i32 0, i32* @count, align 4
  call void @b(i8 zeroext -128)
  %tmp1 = load i32* @count, align 4
  %cmp2 = icmp ne i32 %tmp1, 1
  br i1 %cmp2, label %if.then3, label %if.end4

if.then3:                                         ; preds = %if.end
  call void @abort() noreturn nounwind
  unreachable

if.end4:                                          ; preds = %if.end
  store i32 0, i32* @count, align 4
  call void @b(i8 zeroext 64)
  %tmp5 = load i32* @count, align 4
  %cmp6 = icmp ne i32 %tmp5, 1
  br i1 %cmp6, label %if.then7, label %if.end8

if.then7:                                         ; preds = %if.end4
  call void @abort() noreturn nounwind
  unreachable

if.end8:                                          ; preds = %if.end4
  store i32 0, i32* @count, align 4
  call void @b(i8 zeroext 32)
  %tmp9 = load i32* @count, align 4
  %cmp10 = icmp ne i32 %tmp9, 1
  br i1 %cmp10, label %if.then11, label %if.end12

if.then11:                                        ; preds = %if.end8
  call void @abort() noreturn nounwind
  unreachable

if.end12:                                         ; preds = %if.end8
  store i32 0, i32* @count, align 4
  call void @b(i8 zeroext -64)
  %tmp13 = load i32* @count, align 4
  %cmp14 = icmp ne i32 %tmp13, 2
  br i1 %cmp14, label %if.then15, label %if.end16

if.then15:                                        ; preds = %if.end12
  call void @abort() noreturn nounwind
  unreachable

if.end16:                                         ; preds = %if.end12
  store i32 0, i32* @count, align 4
  call void @b(i8 zeroext -96)
  %tmp17 = load i32* @count, align 4
  %cmp18 = icmp ne i32 %tmp17, 2
  br i1 %cmp18, label %if.then19, label %if.end20

if.then19:                                        ; preds = %if.end16
  call void @abort() noreturn nounwind
  unreachable

if.end20:                                         ; preds = %if.end16
  store i32 0, i32* @count, align 4
  call void @b(i8 zeroext 96)
  %tmp21 = load i32* @count, align 4
  %cmp22 = icmp ne i32 %tmp21, 2
  br i1 %cmp22, label %if.then23, label %if.end24

if.then23:                                        ; preds = %if.end20
  call void @abort() noreturn nounwind
  unreachable

if.end24:                                         ; preds = %if.end20
  store i32 0, i32* @count, align 4
  call void @b(i8 zeroext -32)
  %tmp25 = load i32* @count, align 4
  %cmp26 = icmp ne i32 %tmp25, 3
  br i1 %cmp26, label %if.then27, label %if.end28

if.then27:                                        ; preds = %if.end24
  call void @abort() noreturn nounwind
  unreachable

if.end28:                                         ; preds = %if.end24
  call void @exit(i32 0) noreturn nounwind
  unreachable

return:                                           ; No predecessors!
  %0 = load i32* %retval
  ret i32 %0
}

declare void @abort() noreturn nounwind

declare void @exit(i32) noreturn nounwind
