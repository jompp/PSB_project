%include "io.inc"

;   Grupo: Danilo Oliveira Andrade, João Pedro Costa Chaves

;   Qual e a importancia da escola na democratizacao da sociedade

section .data
temp db 0

section .bss
string resb 61
sub_str resb 41
inverted_str resb 41
no_spaces_str resb 36
interchanged_str resb 41
upper_char_str resb 41
arr resb 41

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor esi, esi
    xor edi, edi
    
    GET_STRING string,61
    
    call Q1
    call Q2
    call Q3
    call Q4
    call Q5
    call Q6
    call Q7
    call print_array_and_mean
    ret
   
; //----------------------------------------//    
     
Q1:
    get_substr:
        mov esi, string
        add esi, 7     ;início da substring
        mov edi, sub_str
        mov ecx, 41     ;quantidade de caracteres da substring
        rep movsb
        PRINT_STRING sub_str
        NEWLINE
        NEWLINE
    ret
        
 ; //----------------------------------------//   
    
Q2:
    mov ebx, 0 ; vamos usar para contar os a's
    mov edx, 0 ; vamos usar para contar os m's
    cld  

    a_counting:
        mov edi, sub_str
        mov eax, 'a'
        mov ecx, 41
        count_a:    
            repne scasb ;itera pela sub_str armazenada em edi até encontrar o a
            jne m_counting ;se não achar mais o a contamos agora os m's
            inc ebx
            jmp count_a
    
    m_counting:
        mov edi, sub_str
        mov eax, 'm'
        mov ecx, 41
        count_m:
            repne scasb 
            jne count_sum ;se não achar mais m's vamos somar somar os contadores
            inc edx
            jmp count_m
        
    count_sum:
        add edx,ebx
        PRINT_DEC 1,edx
        NEWLINE
        NEWLINE
    
    ret 

; //----------------------------------------//

Q3:
    mov edi, inverted_str
    mov ecx, 42
    invert_str:
        std     ;seta a direction flag para decrementar
        lodsb   ;lê a partir do fim da string
        cld     ;seta a direction flag para incrementar
        stosb   ;armazena a partir do início da string
        dec ecx
        jnz invert_str
      
        PRINT_STRING inverted_str
        NEWLINE
        NEWLINE
    ret

; //----------------------------------------//

Q4:
    mov edi, no_spaces_str
    mov ecx, 42
    remove_spaces:
        lodsb
        cmp eax, 32     ;verifica se é espaço
        je loop_remove_spaces   ;não armazena se for espaço
        stosb   ;se não for espaço, armazena
        
        loop_remove_spaces:
            loop remove_spaces
        
        PRINT_STRING no_spaces_str
        NEWLINE
        NEWLINE
    ret

; //----------------------------------------//

Q5:
    mov esi, sub_str
    mov ecx, 7  ;36(string sem espaço) dividido por 5(tamanho do padrão) -> MMmmm...
    mov edi, interchanged_str
    alternate_str:  ;executa 7x o padrão + 1x a procedure de tornar o caracteres maíusculo
        call capitalize
        call capitalize
        call lower_case
        call lower_case
        call lower_case
        loop alternate_str
        call capitalize
        
        PRINT_STRING interchanged_str
        NEWLINE
        NEWLINE
        ret
        
        capitalize: ;se não for espaço, modifica a letra para maiúscula
            lodsb
            cmp eax, 32
            je store_space ;se for espaço, guarda o caractere e passa para o próximo, executando a procedure novamente
            sub al, 32
            stosb
            ret
        
        lower_case: ;se for espaço ou não, guarda o caractere
            lodsb
            cmp eax, 32
            stosb 
            je lower_case ;se for espaço, executa a procedure novamente
            ret
        
        store_space:
            stosb
            jmp capitalize
    ret
    
; //----------------------------------------//

Q6:
    mov ecx, 36
    mov esi, no_spaces_str
    mov edx, 0
    
    get_pos_in_alphabet:
        lodsb                  
        PRINT_CHAR eax
        PRINT_STRING " -> "
        sub eax,96  ;pega posição da letra no alfabeto de acordo com a tabela ascii
        PRINT_DEC 1,eax
        NEWLINE
        mov [arr + edx], eax ;preenche o array que vai ser utilizado na questão 7 com os caracteres da string
        inc edx 
        dec ecx
        jnz get_pos_in_alphabet ;loop no procedure até percorrer toda a string
    ret

; //----------------------------------------//

Q7:
    NEWLINE
    xor eax,eax
    xor edx,edx
    xor ecx,ecx
    xor ebx,ebx
    mov ecx,35

    FOR_i:

        mov eax,ecx
        inc eax
        FOR_j:

            dec eax 
            mov bl,[arr + eax] 
            cmp bl,[arr + ecx]; para cada valor do primeiro loop iremos comparar com o outro valor posterior no vetor
            jl swap ; se esse valor posterior do vetor for menor do que o atual no primeiro loop iremos trocar de posição

            dont_swap:
                cmp eax,0
                jg FOR_j


        ; ao fim de uma iteração do FOR_j teremos 1 valor na posição correta, por isso precisamos fazer isso mais 36 vezes
        loop FOR_i 
        jmp return

    swap: ;troca os valores de forma decrescente
        mov[temp],bl
        mov bl,[arr + ecx]

        mov [arr + eax], bl
        mov bl,[temp]

        mov [arr + ecx],bl

        jmp dont_swap

    return:
        ret


print_array_and_mean:

       xor eax,eax
       xor ebx,ebx
       xor ecx,ecx
       xor edx,edx
       loop:

           mov bl,[arr + ecx]

           add eax,ebx ; adicionamos o valor em cada posição do array no eax
           PRINT_DEC 1,[arr + ecx]
           PRINT_STRING " "

           inc ecx
           cmp ecx,36
           jne loop

        NEWLINE
        NEWLINE
        div ecx

        PRINT_STRING "a media e igual a "
        PRINT_DEC 1,eax
        ret
