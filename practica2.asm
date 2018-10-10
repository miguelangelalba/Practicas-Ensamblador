.data
str: 	.asciiz "El resultado es:"
.text
num1: .word 5
num2: .word 8

main:
	li $v0, 5
	syscall
	move $s0, $v0
	li $v0 , 5
	syscall
	move $s1 , $v0
	add $t1 , $s1 , $s0
	la $a0, str
	li $v0, 4
	syscall
	move $a0 , $t1
	li $v0, 1
	syscall
	li $v0, 10
	syscall
	