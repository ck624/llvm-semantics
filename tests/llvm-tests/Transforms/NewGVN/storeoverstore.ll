; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -newgvn -enable-phi-of-ops=true -S < %s | FileCheck %s
; RUN: opt -passes=newgvn -enable-phi-of-ops=true -S -o - %s | FileCheck %s

target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"

;; All the loads in this testcase are useless, but it requires understanding that repeated
;; stores of the same value do not change the memory state to eliminate them.

define i32 @foo(i32*, i32)  {
; CHECK-LABEL: @foo(
; CHECK-NEXT:    store i32 5, i32* [[TMP0:%.*]], align 4
; CHECK-NEXT:    [[TMP3:%.*]] = icmp ne i32 [[TMP1:%.*]], 0
; CHECK-NEXT:    br i1 [[TMP3]], label [[TMP4:%.*]], label [[TMP5:%.*]]
; CHECK:         br label [[TMP5]]
; CHECK:         [[PHIOFOPS:%.*]] = phi i32 [ 10, [[TMP2:%.*]] ], [ 15, [[TMP4]] ]
; CHECK-NEXT:    [[DOT0:%.*]] = phi i32 [ 10, [[TMP4]] ], [ 5, [[TMP2]] ]
; CHECK-NEXT:    br i1 [[TMP3]], label [[TMP6:%.*]], label [[TMP7:%.*]]
; CHECK:         br label [[TMP7]]
; CHECK:         [[DOT1:%.*]] = phi i32 [ [[PHIOFOPS]], [[TMP6]] ], [ [[DOT0]], [[TMP5]] ]
; CHECK-NEXT:    ret i32 [[DOT1]]
;
  store i32 5, i32* %0, align 4
  %3 = icmp ne i32 %1, 0
  br i1 %3, label %4, label %7

; <label>:4:                                      ; preds = %2
  %5 = load i32, i32* %0, align 4
  %6 = add nsw i32 5, %5
  br label %7

; <label>:7:                                      ; preds = %4, %2
  %.0 = phi i32 [ %6, %4 ], [ 5, %2 ]
  store i32 5, i32* %0, align 4
  %8 = icmp ne i32 %1, 0
  br i1 %8, label %9, label %12

; <label>:9:                                      ; preds = %7
  %10 = load i32, i32* %0, align 4
  %11 = add nsw i32 %.0, %10
  br label %12

; <label>:12:                                     ; preds = %9, %7
  %.1 = phi i32 [ %11, %9 ], [ %.0, %7 ]
  ret i32 %.1
}

;; This is similar to the above, but it is a conditional store of the same value
;; which requires value numbering MemoryPhi properly to resolve.
define i32 @foo2(i32*, i32)  {
; CHECK-LABEL: @foo2(
; CHECK-NEXT:    store i32 5, i32* [[TMP0:%.*]], align 4
; CHECK-NEXT:    [[TMP3:%.*]] = icmp ne i32 [[TMP1:%.*]], 0
; CHECK-NEXT:    br i1 [[TMP3]], label [[TMP4:%.*]], label [[TMP5:%.*]]
; CHECK:         br label [[TMP6:%.*]]
; CHECK:         br label [[TMP6]]
; CHECK:         [[PHIOFOPS:%.*]] = phi i32 [ 10, [[TMP5]] ], [ 15, [[TMP4]] ]
; CHECK-NEXT:    [[DOT0:%.*]] = phi i32 [ 10, [[TMP4]] ], [ 5, [[TMP5]] ]
; CHECK-NEXT:    br i1 [[TMP3]], label [[TMP7:%.*]], label [[TMP8:%.*]]
; CHECK:         br label [[TMP8]]
; CHECK:         [[DOT1:%.*]] = phi i32 [ [[PHIOFOPS]], [[TMP7]] ], [ [[DOT0]], [[TMP6]] ]
; CHECK-NEXT:    ret i32 [[DOT1]]
;
  store i32 5, i32* %0, align 4
  %3 = icmp ne i32 %1, 0
  br i1 %3, label %4, label %7

; <label>:4:                                      ; preds = %2
  %5 = load i32, i32* %0, align 4
  %6 = add nsw i32 5, %5
  br label %8

; <label>:7:                                      ; preds = %2
  store i32 5, i32* %0, align 4
  br label %8

; <label>:8:                                      ; preds = %7, %4
  %.0 = phi i32 [ %6, %4 ], [ 5, %7 ]
  %9 = icmp ne i32 %1, 0
  br i1 %9, label %10, label %13

; <label>:10:                                     ; preds = %8
  %11 = load i32, i32* %0, align 4
  %12 = add nsw i32 %.0, %11
  br label %13

; <label>:13:                                     ; preds = %10, %8
  %.1 = phi i32 [ %12, %10 ], [ %.0, %8 ]
  ret i32 %.1
}
