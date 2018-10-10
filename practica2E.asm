.data

num1: 	.half 2
num2: 	.word 4
	.text
main:
	la $t1, num1
	la $t2, num2
	li $v0, 5
	syscall
	sh $v0,($t1)
	#move $t1, $v0
	li $v0, 5
	syscall
	sw $v0,($t2)
	#move $t2 , $v0
	lh $t3, ($t1)
	lw $t4, ($t2)
	add $t5, $t3, $t4
	#la $a0, str
	move $a0, $t5
	li $v0, 1
	syscall
	li $v0, 10
	syscall
