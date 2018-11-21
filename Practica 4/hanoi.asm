# -- Queremos implementar la torre de Hanoi con el algoritmo propuesto en clase
# -- Normas:
#	- Solo un movimiento por pieza
#	- Las pequeñas se apilan sobre las grandes
#	- 

.data
	num: .space 1024
	mueve_disco: .asciiz "Move disk"
	palo_inicio: .asciiz "from peg"
	palo_fin: .asciiz "to peg"
	introduce: .asciiz "Introduce el número de discos (1-8)"
.text

# Registros utilizados para la práctica
# 	- Registros utilizados para el main
#		- a0 --> Guarudo el numero de discos que le pasa el usuario
#		-

main:

#-- Imprime el mesnsaje inicial
	la $a0 , introduce
	li $v0 , 4
	syscall
#-- Pedir al usuario la cadena wc
	#la $a0, num
	#li $s0, 1024
	li $v0, 5
	syscall
#-- Argumentos
	move $a0,$v0
	li $a1,1
	li $a2,2
	li $a3,3
	jal hanoi
	


#Hanoi
# - A esta rutina se le pasa 4 argumentos:
#	- n
#	- start
#	- finish
#	- extra

# Registros utilzados para la subrutiina:
	# - $t0 --> n-1
hanoi:

#Esqueleto 

	bgez $a0,continua

#Creación de pila:
#Guardo todos los argumentos que he considerado necesario en la pila

	subu $sp, $sp, 32 # Stack frame is 32 bytes long
	sw $ra, 20($sp) # Save return address
	sw $fp, 16($sp) # Save frame pointer
	addiu $fp, $sp, 28 # Inicializo el puntero
	sw $a0, 0($fp) # Guardo el argumento (n "a1")
	sw $a1, 4($fp) # Guardo el argumento (a2)
	sw $a2, 8($fp) # Guardo el argumento (a3)
	sw $a3, 12($fp) # Guardo el argumento (a4)
## Fin de la creación de la pila
#Aún puedo jugar con los argumentos
	subi $a0,$a0,1
	jal hanoi
	#A partir de aquí tengo que hacer llamadas a la pila
	
	#Imprimir movimiento 
	la $a0 , mueve_disco
	li $v0 , 4
	syscall
	#Imprimir n
	lw $a0,0($fp)
	li $v0 , 1
	syscall
	#Imprimir from

#Si es n = 0


continua:




