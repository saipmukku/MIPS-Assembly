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
# The program does this recursively.

# -*- mode: text -*-

        .data
number: .word   0
result: .word   0

        .text
main:   li      $sp, 0x7ffffffc # intializes stack frame

        li      $v0, 5          # puts 5 into function register
        syscall                 # scans value

        move    $t0, $v0        # moves scanned value to $t0
        sw      $t0, number     # stores value in data

        sw      $t0, ($sp)      # stores parameter into stack
        sub     $sp, $sp, 4     # decrements the stack by one word

        jal     catalan         # calls catalan

        add     $sp, $sp, 4     # removes the argument

        move    $t0, $v0        # moves value from $v0 to $t0
        sw      $t0, result     # stores result

        lw      $a0, result     # loads result data to be printed
        li      $v0, 1          # prints integer
        syscall

        li      $v0, 11         # prints newline char
        li      $a0, 10
        syscall

        li      $v0, 10         # quit program
        syscall

catalan:sub	$sp, $sp, 16	# prologue
	sw	$ra, 16($sp)	# stores return address in stack
	sw	$fp, 12($sp)	# stores frame pointer in stack
	add	$fp, $sp, 8	# resets stack pointer
	li	$t0, -1
	sw	$t0, 8($sp)	# stores -1 in ans
	li	$t0, 0		
	sw	$t0, 4($sp)	# sets 
	
	lw	$t1, 4($fp)	# gets the parameter value n

	li	$t2, 0		# loads 0 into $t2
	
	blt	$t1, $t2, ret	# jumps to return if n < 0

	bgt	$t1, $t2, recur # jumps to recur if n > 0

	li 	$t0, 1		# runs only if n == 0
	sw	$t0, 8($sp)	# stores 1 into ans

	j 	ret		# jumps to return sequence

recur:	sub	$t1, $t1, 1	# prologue
	sw	$t1, ($sp)
	sub	$sp, $sp, 4
	jal	catalan
	add	$sp, $sp, 4

	lw      $t0, 4($fp)     # parameter value n
        lw      $t1, 4($sp)     # local variable i
        lw      $t2, 8($sp)     # local variable ans

	mul     $t3, $t1, 2     # does proper calculations
        sub     $t3, $t3, 1     
        mul     $t3, $t3, 2
        mul     $t3, $t3, $t2
        add     $t4, $t1, 1
        div     $t4, $t3, $t4

	sw	$t4, 8($sp)	# stores final value in stack

ret:	lw	$t0, 8($sp)	# loads $t0 into stack
	move 	$v0, $t0	# moves value into $v0

	lw	$ra, 16($sp)	# epilogue
	lw	$fp, 12($sp)
	add	$sp, $sp, 16

	jr	$ra		# return to return address
