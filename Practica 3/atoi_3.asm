#Si encuentra un caracter diferente a ún numero que pare el cálculo
	.data
cad:	.space 1024
num:	.word 0
sign:	.word 1
#nextchar
	.text
	
	#Registros
	# -- S0 es el puntero de cadena "cad"
	# -- S1 va a ser el num actual
	# -- S2 Va ser donde voy a guardar el signo de multiplicación
	# -- T1 va a ser un numero temporal auxiliar "nextChar"
	# -- T2 Es el registro con en el cual voy a guardar el valor \n para compararlo
	
	

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
	# Primero leo unicamente un byte para detectar el signo
	# DEtecteción de signo
	
	lb $t1, 0($s0) # T0 pilla el caracter actual al que apunta s0
		
	lb $s2, sign
	li $t2, '-'
	beq $t1, $t2, nega
	
	b next

nega:
	li $s2, -1
	addi $s0,$s0,1	 #Para pasar al sigueinte byte antes de que empiece la función de leer caracter
		
		
#Función de pasar a numero
	
next:
	lb $t1, 0($s0) # T0 pilla el caracter actual al que apunta s0
	
	#Función para detectar si es un caracter no numerico
	#Lo que voy a hacer es comparar elnumero con la taba ascii
		
	bgt $t1,57,Fin #Si el caracter introducido es mayor que 57
	blt $t1,48,Fin #Si el caracter intruducido es menor a 48 significa que no es un número por lo que termina la ejecución
	
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
	mul $s1 , $s1, $s2
	move $a0, $s1
	li $v0, 1
	syscall
	li $v0,10
	syscall
