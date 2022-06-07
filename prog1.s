# Saipraneeth Mukku
#
# TerpConnect login ID: saipmukk
#
# University ID Number: 118058573
#
# Section Number: 0102
#
# Explanation of program in high-level terms:
# This program takes input as an integer from
# standard input and prints the digits of that
# integer in reverse order to standard output.

# -*- mode: text -*-

	.data
n:	.word 	0
ans:	.word	-1
	
	.text
main:	li	$v0, 5		# reads integer (scanf("%d", &n))
	syscall
	move  	$t0, $v0	# moves value scan register into $t0
	sw	$t0, n		# stores the value now in $t0 into n
	lw	$t0, n		# loads value of n into $t0
	
	beq	$t0, 0, if	# jumps to "if" label if it is 0
	
	rem	$t1, $t0, 10	# stores $t0 mod 10 in register $t1
	beq	$t1, 0, finish	# jumps to finish if n % 10 == 0

	ble	$t0, 0, finish	# jumps to finish if n <= 0

if:	li 	$t1, 0		# loads 0 into register $t1
	sw	$t1, ans	# stores value in $t1 in ans

loop:	lw	$t0, n		# loads value in n to $t0
	lw	$t1, ans	# loads value of ans into $t1

	ble	$t0, 0, finish	# jumps to finish if n <= 0

	mul 	$t1, $t1, 10	# multiplies value in ans by 10
	rem	$t2, $t0, 10	# finds n % 10 and puts it in $t2
	add	$t3, $t1, $t2	# adds the mul value and rem value
	sw	$t3, ans  	# stores value in $t3 into ans

	div 	$t1, $t0, 10	# divides value in $t0 by 10
	sw	$t1, n		# stores value in $t1 in n
	j 	loop

finish:	lw	$a0, ans	# puts value from ans in $a0
	li	$v0, 1		# loads the value 1 into $v0 (prints integer)
	syscall

	li	$v0, 11		# loads 11 into $v0 (prints char)
	li 	$a0, 10		# loads 10 into $a0 (newline char)
	syscall

	li	$v0, 10		# loads 10 into register $v0
	syscall			# quits program
