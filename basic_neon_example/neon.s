	.arch armv5t
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 34, 0
	.eabi_attribute 18, 4
	.file	"neon.c"
	.comm	data1,16,16
	.comm	data2,16,4
	.comm	out,16,4
	.comm	neon_vec_add_save_buffer,64,4
	.text
	.align	2
	.global	neon_vec_add
	.type	neon_vec_add, %function
neon_vec_add:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #20
	str	r0, [fp, #-8]
	str	r1, [fp, #-12]
	str	r2, [fp, #-16]
#APP
@ 21 "neon.c" 1
	   movw        r12, #:lower16:neon_vec_add_save_buffer
	   movt        r12, #:upper16:neon_vec_add_save_buffer
	   stmia       r12, {r4-r11, r13, lr}        @ save registers
	   vld1.16     {q1}, [r0:128]
	   vld1.16     {q2}, [r1:128]
	   vadd.i16    q0, q1, q2
	   vst1.32     {q0}, [r2:128]
	   movw        r12, #:lower16:neon_vec_add_save_buffer
	   movt        r12, #:upper16:neon_vec_add_save_buffer
	   ldmia       r12, {r4-r11, r13, lr}        @ reload all registers and return
	finish:
	
@ 0 "" 2
	add	sp, fp, #0
	ldmfd	sp!, {fp}
	bx	lr
	.size	neon_vec_add, .-neon_vec_add
	.section	.rodata
	.align	2
.LC0:
	.ascii	"output is: \000"
	.align	2
.LC1:
	.ascii	"%d, \000"
	.align	2
.LC2:
	.ascii	"%d\012\000"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L3
.L4:
	ldr	r3, [fp, #-8]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3	@ movhi
	mov	r2, r2, asl #2
	add	r3, r2, r3
	mov	r3, r3, asl #1
	mov	r3, r3, asl #16
	mov	r2, r3, lsr #16
	ldr	r1, .L8
	ldr	r3, [fp, #-8]
	mov	r3, r3, asl #1
	add	r3, r1, r3
	strh	r2, [r3, #0]	@ movhi
	ldr	r2, .L8+4
	ldr	r3, [fp, #-8]
	mov	r3, r3, asl #1
	add	r3, r2, r3
	mov	r2, #5
	strh	r2, [r3, #0]	@ movhi
	ldr	r2, .L8+8
	ldr	r3, [fp, #-8]
	mov	r3, r3, asl #1
	add	r3, r2, r3
	mov	r2, #0
	strh	r2, [r3, #0]	@ movhi
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L3:
	ldr	r3, [fp, #-8]
	cmp	r3, #7
	ble	.L4
	ldr	r0, .L8
	ldr	r1, .L8+4
	ldr	r2, .L8+8
	bl	neon_vec_add
	ldr	r0, .L8+12
	bl	printf
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L5
.L6:
	ldr	r2, .L8+8
	ldr	r3, [fp, #-8]
	mov	r3, r3, asl #1
	add	r3, r2, r3
	ldrh	r3, [r3, #0]
	ldr	r0, .L8+16
	mov	r1, r3
	bl	printf
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L5:
	ldr	r3, [fp, #-8]
	cmp	r3, #6
	ble	.L6
	ldr	r2, .L8+8
	ldr	r3, [fp, #-8]
	mov	r3, r3, asl #1
	add	r3, r2, r3
	ldrh	r3, [r3, #0]
	ldr	r0, .L8+20
	mov	r1, r3
	bl	printf
	mov	r3, #0
	mov	r0, r3
	sub	sp, fp, #4
	ldmfd	sp!, {fp, pc}
.L9:
	.align	2
.L8:
	.word	data1
	.word	data2
	.word	out
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.size	main, .-main
	.ident	"GCC: (Ubuntu/Linaro 4.7.3-12ubuntu1) 4.7.3"
	.section	.note.GNU-stack,"",%progbits
