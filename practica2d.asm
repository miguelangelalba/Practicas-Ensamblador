.data
#str: 	.asciiz "El resultado es:"

num1: 	.word 44
num2: 	.word 44
	.text
main:
	la $t0, num1
	la $t1, num2
	lw $t2, 0 ($t0)
	lw $t3, 0 ($t1)
	
	add $t4 , $t2 , $t3
	#la $a0, str
	#li $v0, 4
	#syscall
	move $a0 , $t4
	li $v0, 1
	syscall
	li $v0, 10
	syscall
	