	#-- Programa que imprima dos números del 1-10 (bucle)
	
	.text
	
	#--- Registro índice: i 
	
	li $v0, 5
	syscall
	move $s2, $v0 #Numero 1
	
	li $v0, 5
	syscall
	move $s3, $v0 #Numero 2
	
	#li $t0,10
	li $s0, 0
	beq $s0 , $s3 , fin
	
next:
	addi $s0 , $s0, 1
	
	 #-- Imprime la tabla de multiplicar
	mul $s4 , $s2 , $s0 
	move $a0 , $s4
	li $v0, 1
	syscall
	li $v0, 11
	li $a0, '\n'
	syscall
	
	beq $s0 , $s3 , fin
	
	b next
	
fin : #--Terminar
	
	li $v0,10
	syscall