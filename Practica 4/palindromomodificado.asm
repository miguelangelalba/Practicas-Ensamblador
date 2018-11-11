#-- REcorrer una cadena introducida por el usuario 
# -- En este programa se quiere implementar una subrutina para detectar una lapabra palíndroma
# -- En caso de ser la función devolverá un 1 en caso negativo devolverá un 0

.data 
	nopal: .asciiz "No es un palíndromo"
	pal: .asciiz "Es un palíndromo"
	cad: .space 1024
	
#Registros utilizados para la práctica
	# -- s0 Guardo el resultado de la subrutina
	# -- S1 Guarda la palabra final que va a imprimir el resultado
	# -- t0 Dirección de la palabra
	# -- t1 Dirección de la palabra
	# -- t2 carga las letras "bites" que va recorriendo el bucle para leer la palabra
	# -- t3 carga las letras "bites" que va recorriendo el bucle para leer la palabra
	# -- t4 va a ser mi segundo puntero
	# -- t7 lo utilizo como varaible auxiliar para la detección de fin de linea
	

.text
main:

#-- Pedir al usuario la cadena wc
	la $a0, cad
	li $a1, 1024
	li $v0, 8
	syscall
	
	#--Imprimir la cadena wc
	la $a0, cad
	li $v0, 4
	syscall
	# Debo pasar a la función s0
	jal palindromo #Le paso el puntero con la palabra para que la subrutina palindormo detecte y devuelva --> 1 / 0
	move $s0 , $v0
	la $s2, pal
	beq $s0,1,fin
	la $s2, nopal
	beqz $s0, fin
	
fin:
	li $v0, 4
	move $a0, $s2
	syscall
	li $v0,10
	syscall



	
palindromo:
	la $t0, 0($a0) # Cargo el argumento de la funcion a un registro temporal, para poder trabajar con él y no tener que crear una pila
	la $t1, 0($a0) # Hago lo mismo ya que necsito dos punteros para recorrer la palabra en ambos sentidos
	
next:
	lb $t2, 0($t0) # T0 pilla el caracter actual al que apunta s0
	
	lb $t3, 0($t0) # Primer puntero
	
	move $a0, $t2
	li $v0, 11
	syscall
	
	addi $t0,$t0,1
	
	li $t7, '\n'
	beq $t2, $t7, detectan
	
	b next
	
detectan : #--Terminar
	
	subi $t4, $t0, 2 
	
next2:
	# -- S1 --> t0
	# -- S3 --> t4
	# -- t5 --> t2
	# -- t4 -- > t3
	lb $t2, 0($t0) #Primer puntero
	lb $t3, 0($t4) #Segundo puntero
# -- A partir de aquí puedo reutilizar mis registros temporales menos t0 y t4 que es donde tengo el principio y fianl de la palabra
	
	move $a0, $t3
	li $v0, 11
	syscall
	bge $t0,$t4 , palindromodetectado
	bne $t2, $t3, nopalindromo
	
	addi $t0,$t0,1 #Avanzo con mi primer puntero
	subi $t4,$t4,1 #Retrocedo con mi primer puntero
	
	b next2
	#li $v0,10
	#syscall
nopalindromo :
	li $v0, 0
	jr $ra

palindromodetectado:

	li $v0, 1
	jr $ra
	
	
	
	
	
	
	
	
	
	
