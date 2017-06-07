; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=x86_64-pc-linux  -mattr=+avx2 < %s | FileCheck %s
define <16 x i8> @foo(<48 x i8>* %x0, <16 x i32> %x1, <16 x i32> %x2) {
; CHECK-LABEL: foo:
; CHECK:       # BB#0:
; CHECK-NEXT:    vmovdqu (%rdi), %ymm4
; CHECK-NEXT:    vmovdqu 32(%rdi), %xmm5
; CHECK-NEXT:    vpextrb $13, %xmm5, %eax
; CHECK-NEXT:    vpextrb $10, %xmm5, %ecx
; CHECK-NEXT:    vpextrb $7, %xmm5, %edx
; CHECK-NEXT:    vpextrb $4, %xmm5, %esi
; CHECK-NEXT:    vpextrb $1, %xmm5, %edi
; CHECK-NEXT:    vextracti128 $1, %ymm4, %xmm5
; CHECK-NEXT:    vpshufb {{.*#+}} xmm6 = xmm5[2,2,5,5,5,5,3,3,4,4,5,5,6,6,7,7]
; CHECK-NEXT:    vpshufb {{.*#+}} xmm7 = xmm4[12,12,13,13,15,15,15,15,12,12,13,13,14,14,15,15]
; CHECK-NEXT:    vpunpcklqdq {{.*#+}} xmm6 = xmm7[0],xmm6[0]
; CHECK-NEXT:    vpshufb {{.*#+}} xmm4 = xmm4[0,0,1,1,3,3,3,3,6,6,9,9,9,9,7,7]
; CHECK-NEXT:    vinserti128 $1, %xmm6, %ymm4, %ymm4
; CHECK-NEXT:    vpand {{.*}}(%rip), %ymm4, %ymm4
; CHECK-NEXT:    vpshufb {{.*#+}} xmm5 = xmm5[8,11,14],zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
; CHECK-NEXT:    vpinsrb $3, %edi, %xmm5, %xmm5
; CHECK-NEXT:    vpinsrb $4, %esi, %xmm5, %xmm5
; CHECK-NEXT:    vpinsrb $5, %edx, %xmm5, %xmm5
; CHECK-NEXT:    vpinsrb $6, %ecx, %xmm5, %xmm5
; CHECK-NEXT:    vpinsrb $7, %eax, %xmm5, %xmm5
; CHECK-NEXT:    vpmovzxbd {{.*#+}} ymm5 = xmm5[0],zero,zero,zero,xmm5[1],zero,zero,zero,xmm5[2],zero,zero,zero,xmm5[3],zero,zero,zero,xmm5[4],zero,zero,zero,xmm5[5],zero,zero,zero,xmm5[6],zero,zero,zero,xmm5[7],zero,zero,zero
; CHECK-NEXT:    vpmulld %ymm0, %ymm4, %ymm0
; CHECK-NEXT:    vpmulld %ymm1, %ymm5, %ymm1
; CHECK-NEXT:    vpsrlvd %ymm2, %ymm0, %ymm0
; CHECK-NEXT:    vpsrlvd %ymm3, %ymm1, %ymm1
; CHECK-NEXT:    vmovdqa {{.*#+}} ymm2 = [0,1,4,5,8,9,12,13,8,9,12,13,12,13,14,15,16,17,20,21,24,25,28,29,24,25,28,29,28,29,30,31]
; CHECK-NEXT:    vpshufb %ymm2, %ymm0, %ymm0
; CHECK-NEXT:    vpermq {{.*#+}} ymm0 = ymm0[0,2,2,3]
; CHECK-NEXT:    vmovdqa {{.*#+}} xmm3 = <0,2,4,6,8,10,12,14,u,u,u,u,u,u,u,u>
; CHECK-NEXT:    vpshufb %xmm3, %xmm0, %xmm0
; CHECK-NEXT:    vpshufb %ymm2, %ymm1, %ymm1
; CHECK-NEXT:    vpermq {{.*#+}} ymm1 = ymm1[0,2,2,3]
; CHECK-NEXT:    vpshufb %xmm3, %xmm1, %xmm1
; CHECK-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    retq
  %1 = load <48 x i8>, <48 x i8>* %x0, align 1
  %2 = shufflevector <48 x i8> %1, <48 x i8> undef, <16 x i32> <i32 0, i32 3, i32 6, i32 9, i32 12, i32 15, i32 18, i32 21, i32 24, i32 27, i32 30, i32 33, i32 36, i32 39, i32 42, i32 45>
  %3 = zext <16 x i8> %2 to <16 x i32>
  %4 = mul <16 x i32> %3, %x1
  %5 = lshr <16 x i32> %4, %x2
  %6 = trunc <16 x i32> %5 to <16 x i8>
  ret <16 x i8> %6
}
