#Se introducen por la consola
	.data

max:	.asciiz "Este es el numero Max: "

	.text
	li $v0, 5
	syscall
	move $s1, $v0
	
	li $v0, 5
	syscall
	move $s2, $v0
	
	bgt $s1 , $s2 grande
	
	b grande2

grande:
	li $v0, 4
	la $a0, max
	syscall
	move $a0, $s1
	li $v0, 1
	syscall
	
	#no son iguales
	#b fin 
	
grande2: # servicio de terminar
	li $v0, 4
	la $a0, max
	syscall
	move $a0, $s2
	li $v0, 1
	syscall
	 	