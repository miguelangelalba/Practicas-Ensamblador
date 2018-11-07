# Tengo que pasar caracteres a números
# En el caso de que se den desboradamientos tengo que tener controlados

.data
	msg:	.asciiz "Detectado desbordamiento"
	msg1:	.asciiz "Número:"
	cad:	.space 1024
	num:	.word 0
	sign:	.word 1 #Inicializo la variable signo a positivo



.text

#Registros
	# -- a0 Lo voy a usar para pasar el argumento signo
	# -- S0 es el puntero de cadena "cad"
	# -- T5 va a ser el num actual
	# -- S2 Va ser donde voy a guardar el signo de multiplicación
	# -- T1 va a ser un numero temporal auxiliar "nextChar"
	# -- T2 Es el registro con en el cual voy a guardar el valor \n para compararlo
	# -- T3 Variable para ver el valor de hi y suma
	# -- En t4 voy a poner el signo
	# -- T6 Va a ser donde almacene mi cadena en atoi
	# -- T7 Va a ser el puntero a la cadena cad
main:

#leer caracteres
	la $a0, cad
	li $a1, 1024
	li $v0, 8
	syscall
#Imprimir caracteres (Los imprime talcual sin una conversión)
	la $a0, cad
	li $v0, 4
	syscall
	
	la $a0, cad
	
	jal atoi #Atoi se va a encargar de cambiar de string --> Number
	
	move $a0 , $v0
	li $v0, 1 #Imprimer el número qeu devuelve atoi
	syscall	
	li $v0,10 #Termino el programa
	syscall
	
atoi:	
	move $t6, $a0
	lb $t1, 0($t6) # T0 pilla el caracter actual al que apunta s0
	lb $t4, sign
	li $t2, '-'
	beq $t1, $t2, nega
	
	b next

nega:
	li $t4, -1
	addi $t6,$t6,1	 #Para pasar al sigueinte byte antes de que empiece la función de leer carac
	
next:
	lb $t1, 0($t6) # T0 pilla el caracter actual al que apunta s0
	
	#Función para detectar si es un caracter no numerico
	#Lo que voy a hacer es comparar elnumero con la taba ascii
		
	bgt $t1,57,Fin #Si el caracter introducido es mayor que 57
	blt $t1,48,Fin #Si el caracter intruducido es menor a 48 significa que no es un número por lo que termina la ejecución
	
	#mul $s1, $s1, 10
	li $t3,10
	multu $t5,$t3
	#En esta función voy a ver que hi sea diferente de 0 si es distinto de 0 terminará de calcular
	#mflo $s1
	mfhi $t3 #sobreescribo registro 3 pero no pasa nada
	bne $t3,0 Fin
	mflo $t5 #Alamaceno despues de la comprobación paraque no me lo imprima mal
	
	sub $t1 ,$t1 , 48

	add $t5 ,$t5 , $t1
	blt $t1,0,Fin #Si el caracter intruducido es menor a 48 significa que no es un número por lo que termina la ejecución
	
	move $a0, $t5
	li $v0, 1
	syscall
	
	addi $t6,$t6,1
	lb $t3, 0($t6) # Para detetectar \n y no modificarlo
	
	li $t2, '\n'
	beq $t3, $t2, Fin	
	
	b next
Fin:
	mul $t5 , $t5, $s2
	move $v0, $a0
	jr $ra
