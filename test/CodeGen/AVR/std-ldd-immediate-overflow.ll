; RUN: llc -O0 < %s -march=avr | FileCheck %s

; Function Attrs: nounwind uwtable
define i32 @std_imm_overflow() #0 {
  %1 = alloca i32
  %2 = alloca [25 x i16]
  %3 = alloca [6 x i16]
  store i32 0, i32* %1

  %4 = getelementptr inbounds [6 x i16], [6 x i16]* %3, i32 0, i32 0
  store i16 0, i16* %4
  %5 = getelementptr inbounds [6 x i16], [6 x i16]* %3, i32 0, i32 1
  store i16 1, i16* %5
  %6 = getelementptr inbounds [6 x i16], [6 x i16]* %3, i32 0, i32 2
  store i16 2, i16* %6
  %7 = getelementptr inbounds [6 x i16], [6 x i16]* %3, i32 0, i32 3
  store i16 3, i16* %7
  %8 = getelementptr inbounds [6 x i16], [6 x i16]* %3, i32 0, i32 4
  store i16 4, i16* %8
  %9 = getelementptr inbounds [6 x i16], [6 x i16]* %3, i32 0, i32 5
  store i16 5, i16* %9
; CHECK-NOT: std {{[XYZ]}}+64, {{r[0-9]+}}

  ret i32 0
}
