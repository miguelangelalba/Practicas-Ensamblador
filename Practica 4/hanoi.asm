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

hanoi:

#Esqueleto 

#Si es n = 0




