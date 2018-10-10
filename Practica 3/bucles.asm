	#-- Programa que imprima dos números del 1-10 (bucle)
	
	.text
	
	#--- Registro índice: i 
	
	li $t0,10
	li $s0, 0 
next:
	addi $s0 , $s0, 1
	
	 #-- Imprimir el índice
	move $a0 , $s0
	
	li $v0, 1
	syscall
	li $v0, 11
	li $a0, '\n'
	syscall
	
	beq $s0 , $t0 , fin
	
	b next
	
fin : #--Terminar
	
	li $v0,10
	syscall