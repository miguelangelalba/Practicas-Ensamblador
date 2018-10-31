## ---Calcular la secuecnia de fibonacci de manera recursiva
## --- Queremos implementear la función F(n)
## --- F(n) = 1, si n<= 2
## --- F(n) = F(n-1) + F(n-2) , n>2
## ---
## --- n:   1 2 3 4 5 6 7   8   9   10
## --- F(n) 1 1 2 3 5 8 13  21  34  55


##Variable general
	.data
msg1:	.asciiz "Termino n de fobonazzi"

	.text
# Progrmaa principal

main:
	li $v0, 4
	la $a0, msg1
	syscall 
	#--Llamar a fibonacci
	li $a0, 10
	jal fibonacci
	
	#Imprimir
	move $a0,$v0
	li $v0,1
	syscall
	
	li $v0,10
	syscall

#Funcion fibonacci
fibonacci:
	#--- Condición de terminación
	bgt $a0, 2, fibo_recur
	#--- Si n <2
	
	li $v0, 1
	jr $ra
fibo_recur:
	#Creamos la pila
	subu $sp, $sp,32 #Por convenio siempre se utiliza marcos de pila de 32
	sw $ra, 20($sp) #Por convenio lo guardamos aquí
	sw $fp, 16($sp) #
	addiu $fp, $sp, 24 #En este caso se gaurda  aquí porque vamos a guardas 2
	
	#--- Guardar n en la pila
	
	sw $a0, 0($fp)
	
	#--- Calcular F(n-1)
	subi $a0, $a0, 1
	jal fibonacci 	
	# --V0 --> F(n-1)
	sw $v0, 4($fp)
	#--Calcular F(n-2)
	lw $a0, 0($fp)
	subi $a0, $a0, 2
	jal fibonacci
	
	# -- v0 --> F(n-2)
	
	#-- Calculo final: F(n-1) + F(n-2)
	lw $v1, 4($fp) #-- F(n-1)
	add $v0, $v0, $v1
	
	#-- Recuperar el carco del pila
	
	lw $ra,20 ($sp)
	lw $fp,16 ($sp)
	addiu $sp, $sp, 32
		
	#li $v0,2
	jr $ra