# Kate Malinis	<kgm170030>	CS 3340 Assignment 2
# what.s calculated the square of a number through repeated addition.
# The program works even if the argument is changed.
# My modified program, additive_multiplication.s multiplies two numbers through repeated addition.

	.data	
arg1:	.word	0
arg2:	.word	0
product: .word 0
prompt1: .asciiz "Enter the first integer: "
prompt2: .asciiz "\nEnter the second integer: "
error:	.asciiz "\nYou entered a negative number, output is 0."
output:	.asciiz	"\nThe result is: "
	.text
	.globl main

main:
	la	$a0, prompt1	# prompt for first int
	li	$v0, 4		# syscall code for printing string
	syscall			
	li	$v0, 5		# syscall code for reading int
	syscall
	sw 	$v0, arg1	# move contents of $v0 to arg1

	la 	$a0, prompt2	# prompt for second int
	li	$v0, 4		# syscall code for printing string
	syscall
	li 	$v0, 5		# read the second int
	syscall
	sw	$v0, arg2	# move contents of $v0 to arg2	

	addi	$9, $zero, 0	# $9 = 0 + 0
	addi	$10, $zero, 0	# $10 = 0 + 0
	lw	$11, arg1	# $11 = arg1
	lw	$12, arg2	# $12 = arg2
	
	# comparison tests
	beqz	$11, fin	# if $11 == 0 --> fin
	beqz	$12, fin	# if $12 == 0 --> fin
	blt	$11, 0, zero_prompt	# if $11 < 0 --> zero_prompt
	blt	$12, 0, zero_prompt	# if $12 < 0 --> zero_prompt
	
multiply:
	beq	$10, $11, fin	# if $10 == $11 --> fin
	addi	$10, $10, 1	# $10 = $10 + 1
	add	$9, $9, $12	# $9 = $9 + $12
	j multiply		# jump back to beginning of loop
	
	sw	$9, product	# $9 = product

zero_prompt:
	addi	$9, $zero, 0	# $9 = 0 + 0
	
	li	$v0, 4		# syscall code for printing string
	la	$a0, error	# load address of $a0, which contains error
	syscall			

	li	$v0, 10		# syscall code for exit
	syscall

fin:
	li	$v0, 4		# syscall code for printing string
	la 	$a0, output	# load the address of $a0, which contains output 
	syscall

	lw	$a0, product	# $a0 = product
	move	$a0, $9		# $a0 = $9
	li	$v0, 1		# syscall code for printing int
	syscall	

	li $v0, 10		# syscall code for exit
	syscall		