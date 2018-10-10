#Programa para comparar dos números
#Se introducen por la consola
	.data
cad: 	.asciiz "Los numeros son iguales\n"
Max:	.asciiz "Este es el numero Max"
	.text
	li $v0, 5
	syscall
	move $s1, $v0
	
	li $v0, 5
	syscall
	move $s2, $v0
	
	beq $s1 , $s2, iguales
	
	bgt $s1 , $s2 grande
	

grande:
	li $v0, 4
	la $a0, cad
	syscall
	
	li $v0, 4
	la $a0, ($s1)
	syscall
	
	#no son iguales
	#b fin 
			
iguales: #Los numeros son iguales
	li $v0, 4
	la $a0, cad
	syscall
	
fin: # servicio de terminar
	li $v0, 10
	syscall
	#Terminar 	
