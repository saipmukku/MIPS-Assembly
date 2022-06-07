# Saipraneeth Mukku
#
# TerpConnect login ID: saipmukk
#
# University ID Number: 118058573
#
# Section Number: 0102
#
# Explanation of program in high-level terms:
# This program takes in standard input as an
# integer, and outputs the correct value
# based on the catalan sequence of values.

# -*- mode: text -*-

	.data
number:	.word	0
result:	.word	0

	.text
main:	li	$sp, 0x7ffffffc	# intializes stack frame

	li	$v0, 5		# puts 5 into function register
	syscall	     		# scans value

	move	$t0, $v0	# moves scanned value to $t0
	sw	$t0, number	# stores value in data

	sw	$t0, ($sp)	# stores parameter into stack
	sub	$sp, $sp, 4	# decrements the stack by one word

	jal 	catalan		# calls catalan

	add	$sp, $sp, 4	# removes the argument

	move	$t0, $v0  	# moves value from $v0 to $t0
	sw	$t0, result	# stores result

	lw	$a0, result	# loads result data to be printed
	li	$v0, 1		# prints integer
	syscall

	li	$v0, 11		# prints char
	li	$a0, 10		# prints newline char
	syscall

	li	$v0, 10		# quit program
	syscall
	
catalan:sub	$sp, $sp, 16	# beginning of prologue
	sw	$ra, 16($sp)	# saves return address
	sw	$fp, 12($sp)	# saves frame pointer
	add	$fp, $sp, 16	# sets frame pointer
	li	$t0, -1		# puts -1 into $t0
	sw	$t0, 8($sp)	# stores value in stack
	li	$t0, 1		# puts 1 into $t0
	sw	$t0, 4($sp)	# stores value in stack

	lw	$t0, 4($fp)	# retrieves parameter value
	li	$t1, 0		# loads 0 into $t1

	blt	$t0, $t1, ret	# returns value if n < 0
	
	li	$t0, 1
	sw	$t0, 8($sp)	# sets ans to 1
	move	$t4, $t0

	lw	$t0, 4($fp)	# parameter value n
	lw	$t1, 4($sp)	# local variable i

for:	bgt	$t1, $t0, ret	# jumps to ret if fails loop condition

	lw	$t0, 4($fp)	# parameter value n
	lw	$t1, 4($sp)	# local variable i
	lw	$t2, 8($sp)	# local variable ans

	mul	$t3, $t1, 2	# does proper calculations
	sub	$t3, $t3, 1	
	mul	$t3, $t3, 2
	mul	$t3, $t3, $t2
	add	$t4, $t1, 1
	div	$t4, $t3, $t4

	sw	$t4, 8($sp)	# stores ans value in stack

	add	$t1, $t1, 1	# increments i
	sw	$t1, 4($sp)	# stores i

	j	for

ret:	move	$v0, $t4	# moves final return val

	lw	$ra, 16($sp)	# resets return address
	lw	$fp, 12($sp)	# resets frame pointer
	add	$sp, $sp, 16	# resets stack pointer

	jr	$ra  	  	# returns to calling function
