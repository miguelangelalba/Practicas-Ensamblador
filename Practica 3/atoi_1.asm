# Leer una cadena de texto y pasarla a número 
# Primero se hará con caracteres numéricos para pasar a número

#Mientras que no sea \n 
# num = num * 10
# num = num + (nextChar - '0')
#Varialbles
	.data
cad:	.space 1024
num:	.word 0
#nextchar
	.text
	
	#Registros
	# -- S0 es el puntero de cadena "cad"
	# -- S1 va a ser el num actual
	# -- T1 va a ser un numero temporal auxiliar "nextChar"
	# -- T3 Es el registro con en el cual voy a guardar el valor \n para compararlo
	
	

#Función lectura de cadena de caracteres
	la $a0, cad
	li $a1, 1024
	li $v0, 8
	syscall
#Función Imprimir la cadena 
	la $a0, cad
	li $v0, 4
	syscall
	
	la $s0, cad
	lw $s1, num
next:
	lb $t1, 0($s0) # T0 pilla el caracter actual al que apunta s0
	
	mul $s1, $s1, 10
	sub $t1 ,$t1 , 48
	add $s1 ,$s1 , $t1
	
	move $a0, $s1
	li $v0, 1
	syscall
	
	addi $s0,$s0,1
	lb $t3, 0($s0) # Para detetectar \n y no modificarlo
	
	li $t2, '\n'
	beq $t3, $t2, Fin	
	
	b next
	
Fin:
	move $a0, $s1
	li $v0, 1
	syscall
	li $v0,10
	syscall





