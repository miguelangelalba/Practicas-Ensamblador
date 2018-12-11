#lo primero de todo, pedir al usuario los valores
	#Se le pide al usuario el valor de la pila
	
	li $v0, 5
	syscall
	move $a0, $v0
	#Con el 0 la función create node detectará qeu es el primer nodo en crear
	li $a1, 0
	jal node_t_create
	
	move $s0, $v0 #De esta manera almaceno el puntero del inicio de la memoria
	
	#prin para ver si se está haciendo bien el salvado de la memoria
	lw $t0, 0($s0)
	move $a0, $t0
	li $v0,1
	syscall
	
while: #Esto es para entender que empieza mi bucle
	li $v0, 5
	syscall
	move $t1, $v0
	#Tengo que ver si el usuario a introducido un 0 si no continuo
	beqz $t1 , fin
	
	move $a0 , $s0
	move $a1 , $t1
	jal node_t_push
	
	move $s0 , $v0
	lw $t0, 0($s0)
	move $a0, $t0
	li $v0,1
	syscall
	
	b while
	
#Función crear nodo
node_t_create:
	# creación de la pila
	subu $sp, $sp, 32
	sw $ra , 8($sp)
	sw $fp , 12($sp)
	addiu $fp, $sp , 16 
	sw $a0 , 0($fp)
	sw $a1 , 4($fp)
	#En esta función tendré que conseguir una dirección de memoria donde almacenar el valor que me pasen
	#Lo primeroque tengo que hacer es pedir al sistema memoria
	#Puesto que quiero almacenar dos palabras la siguiente dirección y el valor el tamaño de la memoria será de 8 bytes
	li $a0, 8
	li $v0, 9
	syscall
	#Cuidado aquí ya se han reseteado todos los valores de los registros no s por lo que asegurate de tener una pila
	#v0 --> en este punto tengo el puntero del montón
	lw $t0, 0($fp)
	lw $t1, 4($fp)
	
	sw $t0, 0($v0)
	sw $t1, 4($v0)
	
	#Recupero ra y reseteo pila para no tener problemas en un futuro
	lw $ra, 8($sp)
	lw $fp, 12 ($sp) 
	addiu $sp, $sp, 32
	#a0 sigue valiendo lo mismo ya que no he lleamado a ninguna subrutina por lo que sigue con el puntero a la dirección de memoria
	#move $v0 ,$a0
	jr $ra

#Función insertar nodo
	#Necesitará saber el principio de la lista
	#Esta función tendrá que llamar a la función crear nodo para posteriormente insertar el nodo
node_t_push:
	#Crear pila
	subu $sp, $sp, 32
	sw $ra , 8($sp)
	sw $fp , 12($sp)
	addiu $fp, $sp , 16 
	sw $a0 , 0($fp) # --> Direccion del puntero
	sw $a1 , 4($fp) # --> Valor del puntero
	
	#Preparo los argumentos para la subrutina crar nodo paso valor y puntero
	lw $a0 , 4($fp)
	lw $a1 , 0($fp)
	
	jal node_t_create

	lw $ra, 8($sp)
	lw $fp, 12 ($sp) 
	addiu $sp, $sp, 32
	
	jr $ra
	
	

#Función borrar nodo
	#A esta función se le tendrá que pasar el nodo que se quiere borrar y el comienzo de la lista
#función node print
node_t_print:
	
fin:
	 # Con esta función termino el programa ya que el usuario a introducido un 0
	li $v0,10
	syscall
