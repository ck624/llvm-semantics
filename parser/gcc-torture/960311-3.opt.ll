; ModuleID = '/home/grosu/celliso2/c-semantics/tests/gcc-torture/960311-3.ll'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-unknown-linux-gnu"

@count = common global i32 0, align 4

define i32 @gnu_dev_major(i64 %__dev) nounwind uwtable readnone inlinehint {
entry:
  %shr = lshr i64 %__dev, 8
  %and = and i64 %shr, 4095
  %shr2 = lshr i64 %__dev, 32
  %and3 = and i64 %shr2, 4294963200
  %or = or i64 %and, %and3
  %conv5 = trunc i64 %or to i32
  ret i32 %conv5
}

define i32 @gnu_dev_minor(i64 %__dev) nounwind uwtable readnone inlinehint {
entry:
  %and = and i64 %__dev, 255
  %shr = lshr i64 %__dev, 12
  %and2 = and i64 %shr, 4294967040
  %or = or i64 %and2, %and
  %conv4 = trunc i64 %or to i32
  ret i32 %conv4
}

define i64 @gnu_dev_makedev(i32 %__major, i32 %__minor) nounwind uwtable readnone inlinehint {
entry:
  %and = and i32 %__minor, 255
  %and2 = shl i32 %__major, 8
  %shl = and i32 %and2, 1048320
  %or = or i32 %and, %shl
  %conv = zext i32 %or to i64
  %and4 = and i32 %__minor, -256
  %conv5 = zext i32 %and4 to i64
  %shl6 = shl nuw nsw i64 %conv5, 12
  %and9 = and i32 %__major, -4096
  %conv10 = zext i32 %and9 to i64
  %shl11 = shl nuw i64 %conv10, 32
  %or7 = or i64 %shl6, %shl11
  %or12 = or i64 %or7, %conv
  ret i64 %or12
}

define void @a1() nounwind uwtable {
entry:
  %tmp = load i32* @count, align 4
  %inc = add nsw i32 %tmp, 1
  store i32 %inc, i32* @count, align 4
  ret void
}

define void @b(i64 %data) nounwind uwtable {
entry:
  %and = and i64 %data, 2147483648
  %tobool = icmp eq i64 %and, 0
  br i1 %tobool, label %if.end, label %if.then

if.then:                                          ; preds = %entry
  %tmp.i = load i32* @count, align 4
  %inc.i = add nsw i32 %tmp.i, 1
  store i32 %inc.i, i32* @count, align 4
  br label %if.end

if.end:                                           ; preds = %entry, %if.then
  %and3 = and i64 %data, 1073741824
  %tobool4 = icmp eq i64 %and3, 0
  br i1 %tobool4, label %if.end6, label %if.then5

if.then5:                                         ; preds = %if.end
  %tmp.i3 = load i32* @count, align 4
  %inc.i4 = add nsw i32 %tmp.i3, 1
  store i32 %inc.i4, i32* @count, align 4
  br label %if.end6

if.end6:                                          ; preds = %if.end, %if.then5
  %and10 = and i64 %data, 536870912
  %tobool11 = icmp eq i64 %and10, 0
  br i1 %tobool11, label %if.end13, label %if.then12

if.then12:                                        ; preds = %if.end6
  %tmp.i1 = load i32* @count, align 4
  %inc.i2 = add nsw i32 %tmp.i1, 1
  store i32 %inc.i2, i32* @count, align 4
  br label %if.end13

if.end13:                                         ; preds = %if.end6, %if.then12
  ret void
}

define i32 @main() noreturn nounwind uwtable {
if.end12:
  store i32 3, i32* @count, align 4
  tail call void @exit(i32 0) noreturn nounwind
  unreachable
}

declare void @exit(i32) noreturn nounwind
