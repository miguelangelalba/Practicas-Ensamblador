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
#		- S0 --> Guarudo el numero de pesos que le pasa el usuario

main:


	la $a0 , introduce
	li $v0 , 4
	syscall
#-- Pedir al usuario la cadena wc
	la $a0, num
	li $s0, 1024
	li $v0, 8
	syscall






#Hanoi
# - A esta rutina se le pasa 4 argumentos:
#	- n
#	- start
#	- finish
#	- extra

hanoi:
