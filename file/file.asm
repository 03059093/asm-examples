.data
prompt: .asciiz "Enter a positive integer N (N >= 25): "
error_msg: .asciiz "Illegal Number!\n"

.text
.globl main

main:
    # Step 1: Prompt user for input
    li $v0, 4              # System call to print string
    la $a0, prompt         # Load address of prompt message
    syscall                # Print the prompt message

read_input:
    # Step 1: Read integer input
    li $v0, 5              # System call to read integer input
    syscall                # Read integer from console
    move $t0, $v0          # Store N in $t0
    # Step 1: Check if N is legal (N >= 25)
    bge $t0, 25, legal_input # If N >= 25, jump to legal_input
    li $v0, 4              # System call to print string
    la $a0, error_msg      # Load address of error message
    syscall                # Print error message
    j read_input           # Jump back to read_input
legal_input:
    # Step 2: Print Fibonacci sequence
    li $t1, 0              # F(0) = 0
    li $t2, 1              # F(1) = 1

    # Print F(0)
    li $v0, 1              # System call to print integer
    move $a0, $t1          # Load F(0) into $a0
    syscall                # Print F(0)
    # Print F(1)
    li $v0, 1              # System call to print integer
    move $a0, $t2          # Load F(1) into $a0
    syscall                # Print F(1)

    # Calculate and print the rest of the Fibonacci sequence
    sub $t0, $t0, 2        # Subtract 2 from N (since F(0) and F(1) are printed)
    j fibonacci_loop       # Jump to the Fibonacci loop
fibonacci_loop:
    # Calculate F(i) = F(i-1) + F(i-2)
    add $t3, $t1, $t2      # F(i) = F(i-1) + F(i-2)

    # Print F(i)
    li $v0, 1              # System call to print integer
    move $a0, $t3          # Load F(i) into $a0
    syscall                # Print F(i)
  # Update values for the next iteration
    move $t1, $t2          # F(i-1) = F(i)
    move $t2, $t3          # F(i) becomes F(i-1) for next iteration
    sub $t0, $t0, 1        # Decrement the loop counter (N--)

    # Continue loop if N is not zero
    bnez $t0, fibonacci_loop # If N != 0, continue loop
  # Exit the program
    li $v0, 10             # System call to exit the program
    syscall   
