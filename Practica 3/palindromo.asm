	#-- REcorrer una cadena introducida por el usuario 
	.data 
nopal: .asciiz "No es un palíndromo"
pal: .asciiz "Es un palíndromo"

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
	la $s1, cad
next:
	lb $t0, 0($s0) # T0 pilla el caracter actual al que apunta s0
	
	lb $t3, 0($s0) # Primer puntero

	move $a0, $t0
	li $v0, 11
	syscall
	
	addi $s0,$s0,1
	
	li $t1, '\n'
	beq $t0, $t1, detectan
	
	b next
	
detectan : #--Terminar
	
	subi $s3, $s0, 2 #s3 va a ser mi segundo puntero
next2:
	lb $t5, 0($s1) #Primer puntero
	lb $t4, 0($s3) #Segundo puntero
	
	move $a0, $t4
	li $v0, 11
	syscall
	bge $s1,$s3 , palindromo
	bne $t5, $t4, nopalindromo
	
	addi $s1,$s1,1 #Avanzo con mi primer puntero
	subi $s3, $s3,1 #Retrocedo con mi primer puntero
	
	b next2
	#li $v0,10
	#syscall
	
nopalindromo :
	li $v0, 4
	la $a0, nopal
	syscall
	li $v0,10
	syscall
palindromo:

	li $v0, 4
	la $a0, pal
	syscall
	li $v0,10
	syscall