	#-- REcorrer una cadena introducida por el usuario 
	.data 
cad: .space 1024

	.text
	
	#-- Pedir al usuario la cadena wc
	la $a0, cad
	li $a1, 1024
	li $v0, 8
	syscall
	
	#--Imprimir la cadena wc
	la $a0, cad
	li $v0, 4
	syscall
	
	#-- S0 es el puntero. Inicialmente apunta al primer cararter de la cadena wc
	la $s0, cad
next:
	lb $t0, 0($s0) # T0 pilla el caracter actual al que apunta s0
	move $a0, $t0
	li $v0, 11
	syscall
	
	addi $s0,$s0,1
	
	li $t1, '\n'
	beq $t0, $t1, fin
	
	b next
	
fin : #--Terminar
	
	li $v0,10
	syscall
	
	