# -- Queremos implementar la torre de Hanoi con el algoritmo propuesto en clase
# -- Normas:
#	- Solo un movimiento por pieza
#	- Las pequeñas se apilan sobre las grandes
#	- 

.data
	num: .space 1024
	mueve_disco: .asciiz " Move disk "
	palo_inicio: .asciiz " from peg "
	palo_fin: .asciiz " to peg "
	salta: .asciiz "\n"
	fin: .asciiz " Fin del programa "
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
	
	
#-- Imprime el mesnsaje inicial
	la $a0 , fin
	li $v0 , 4
	syscall	
	li $v0,10
	syscall
		
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

	bne $a0,0,hanoi_recursivo ## voy a janoi recursivo paracrear pila y quitar valores
	jr $ra
	
hanoi_recursivo:
	#Creo pila guardo los argumentos en la pila
	
	subu $sp, $sp, 32 # Stack frame is 32 bytes long
	sw $ra, 8($sp) # Save return address
	sw $fp, 12($sp) # Save frame pointer
	addiu $fp, $sp, 16 # Inicializo el puntero
	sw $a0, 0($fp) # Guardo el argumento (n "a1")
	sw $a1, 4($fp) # Guardo el argumento (a2)
	sw $a2, 8($fp) # Guardo el argumento (a3)
	sw $a3, 12($fp) # Guardo el argumento (a4)
	
	subi $a0, $a0, 1
	
	jal hanoi
			
	#Imprimir movimiento 
	la $a0 , mueve_disco
	li $v0 , 4
	syscall
	#Saco el fp con el sp ya que así lo estipula el convenio
	#lw $fp,12($sp)
	#Imprimir n
	lw $a0,0($fp)
	li $v0 , 1
	syscall
	#Imprimir from
	la $a0 , palo_inicio
	li $v0 , 4
	syscall
	#Imprimir el número inicio
	lw $a0,4($fp)
	li $v0 , 1
	syscall
		
	#Imprimir fin movimiento 
	la $a0 , palo_fin
	li $v0 , 4
	syscall
	
	#Imprimir el número fin
	lw $a0,12($fp)
	li $v0 , 1
	syscall
	
	#Imprimir salto de linea
	la $a0 ,salta
	li $v0 , 4
	syscall	
	
	#Paso los argumentos en el orden que pide el algoritmo
	lw $a0,0($fp)
	lw $a1,8($fp)
	lw $a2,12($fp)
	lw $a3,4($fp)
	
	subi $a0, $a0, 1
	jal hanoi
	
	# "Borro pila" y dejo como etaba el fp y el ra para que en la siguiente itereación lo tenga y pueda continuar el programa
	lw $ra, 8($sp)
	lw $fp, 12($sp)
	addiu $sp, $sp, 32
	jr $ra
