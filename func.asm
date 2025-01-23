SetConsoleCursorPosition proto
ReadConsoleA proto
Sleep proto
puts proto
rand proto
printf proto
.data 
	spaces db "                                                                        ",0
	p db "%llu * %llu = ",0
	p2 db "correct: %llu, wrong %llu, total: %llu ,time ",0
	num1 dq 0
	num2 dq 0
	prod dq 0
	user dq 0
	buf db 30 dup(0)
	temp dq 0
	wrong dq 0
	correct dq 0
.code

	cleen_line proc
		sub rsp,32
		mov r15,rcx
		mov r14,rdx
		call SetConsoleCursorPosition
		mov rcx,offset spaces
		call puts
		mov rcx,r15
		mov rdx,r14
		call SetConsoleCursorPosition
		add rsp,32
		ret
	cleen_line endp

	gen_num proc
		xor rax,rax
		xor rdx,rdx
		xor r14,r14
		sub rsp,32
		call rand
		mov r15,9
		div r15
		inc dl
		xor rcx,rcx
		mov cl,dl
		add r14,rcx
		mov r15,10
		dec rsi
		jz finish_gen
		run:
			call rand
			xor rdx,rdx
			div r15
			xor rcx,rcx
			mov r13,rdx
			mov rax,r14
			xor rdx,rdx
			mul r15
			add rax,r13
			mov r14,rax
			dec rsi
			jnz run
		finish_gen:
		add rsp,32
		ret
	gen_num endp

	print_exercise proc
		mov rsi,rcx
		mov r12,rcx
		call gen_num
		mov num1,r14
		mov rsi,r12
		call gen_num
		mov num2,r14
		sub rsp,88
		mov rcx,offset p
		mov rdx,num1
		mov r8,num2
		call printf
		add rsp,88
		mov rax,num1
		mov rbx,num2
		xor rdx,rdx
		mul num2
		mov prod,rax
		ret
	print_exercise endp

	input proc
		mov rdx,offset buf
		mov r8,30
		mov r9,offset temp
		push 0h
		call ReadConsoleA
		pop rdx
		lea rsi,buf
		xor rax,rax
		xor rdx,rdx
		mov rbx,10
		run_input:
			xor rdx,rdx
			mul rbx
			xor rcx,rcx
			mov cl,[rsi]
			sub cl,48
			add rax,rcx
			inc rsi
			cmp byte ptr[rsi],13
			jne run_input
		mov user,rax
		ret
	input endp

	check proc
		mov rax,prod
		cmp rax,user
		jne wrong_answer
		inc correct
		jmp end_check
		wrong_answer:
		inc wrong
		end_check:
		ret
	check endp

	zero proc
		xor rax,rax
		mov wrong,rax
		mov correct,rax
		ret
	zero endp

	one_exersice proc
		push rdx
		push r8
		push r9
		call print_exercise
		pop rcx
		sub rsp,32
		call Sleep
		add rsp,32
		pop rdx
		pop rcx
		push rdx
		push rcx
		xor rdx,rdx
		call cleen_line
		pop rdx
		pop rcx
		push rdx
		call input
		call check
		pop rcx
		call cleen_line
		ret
	one_exersice endp

	print_results proc
		mov rcx,offset p2
		mov rdx,correct
		mov r8,wrong
		mov r9,correct
		add r9,wrong
		sub rsp,328
		call printf
		add rsp,328
		ret
	print_results endp


end