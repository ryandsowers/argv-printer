;Code modified/updated by Ryan Sowers
;Submitted: 03/01/2018
;CS3140 Assignment 3 - Part 2
;Assemble: 	nasm -f elf64 -g assign3_part2.asm
;Compile:	gcc -o assign3_part2 -m64 assign3_part2.o
;Run:		./assign3_part2 <optional arg> <optional arg>


bits 64

section .text

global main
extern printf
extern exit

main:
	mov r12, rsi			;argv pointer
	mov r13, rdx			;envp pointer
	
print_argv:
	xor rax, rax
	mov eax, 0
	mov rsi, [r12 + 8*r14]	;pointer to next output string
	mov rdi, format			;output format with NL and NULL term
	cmp rsi, 0				;if Null, skip to envp vars
	je envp_vars
	
	call printf				;print

	inc r14					;next index
	jmp print_argv

envp_vars:
	xor rax, rax
	mov eax, 0
	mov rsi, [r13 + 8*r15]	;pointer to next output string
	mov rdi, format			;output format with NL and NULL term
	cmp rsi, 0				;if Null, skip to exit call
	je exit_call
	
	call printf				;print

	inc r15					;next index
	jmp envp_vars

exit_call:
	xor rdi, rdi			;return value of zero
	call exit


section .data
format: db '%s',0xA,0		;format with NL and NULL term













