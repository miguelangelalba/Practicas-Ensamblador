#-- El programa debe calcular los 100 primeros numeros primos, es decir qeu solo tengan dos divisores distintos. 
# -- Para ello se implementara un procedimiento principar y una subrutina que devovlerá 1 o 0 en caso de que encuentre el número primo.
# -- En caso de ser primo devolverá un 1 en caso negativo devolverá un 0

.data 
	salta: .asciiz "\n"
.text
#Registros utilizados para la práctica
	# -- s0 Guarda las iteracciones del bucle para de 0-99 para ir sacando los números primos (La inicializo en 0)
	
	# -- S1 Guarda la palabra final que va a imprimir el resultado
	# -- S2 Guarda el valor que devuelve la subrutina primo
	# -- t0 Valor del numero para ver si es primo
	# -- t1 Contador de divisores
	# -- t2 Limite de división 1-9
	# -- t3 Guardo el resto de la división



main:
	li $s0,0
	li $t1,8
	li $t2,2
	div $t1,$t2

	loop:
		move $a0,$s0

		#Aprovecho que el valor qeu  lte tengoque pasar a la subrutina está en a0
		jal primo #Le paso el puntero con la palabra para que la subrutina palindormo detecte y devuelva --> 1 / 0
		beq $s0,99,fin
		move $s2,$v0
		beq $s2,1,imprimirprimo
		addi $s0,$s0,1
	b loop
	
imprimirprimo:
	move $a0,$s0
	li $v0,1
	syscall
	la $a0 ,salta
	li $v0 , 4
	syscall
	addi $s0,$s0,1
	b loop

fin:
	li $v0,10
	syscall
###-------------------------Subrutina Primo-------------------------------###
primo:
	move $t0, $a0
	li $t1,0
	li $t2,1
	
	loop2:
		div $t0,$t2
		mfhi $t3
		beq $t2,99,resultadoprimo
		beqz $t3,suma
		addi $t2,$t2,1
		
	b loop2
	
resultadoprimo:
	beq $t1,2, esprimo
	#No es primo
	li $v0, 0
	jr $ra
	
esprimo:
	li $v0, 1
	jr $ra
		
suma:
	addi $t1,$t1,1
	addi $t2,$t2,1 # Esto lo hago ya que alsaltar en ete punto no se ha sumado la función
	b loop2
	



