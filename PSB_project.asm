%include "io.inc"

;qual e a importancia da escola na democratizacao da sociedade



section .bss
string resb 61
sub_str resb 41
inverted_str resb 41
no_spaces_str resb 35
upper_char_str resb 41
v resb 41

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
    mov esi, string
    call Q1
    call Q2
    call Q3
    call Q4
    
   
    call Q5

    call Q6
    
    call Q7
    ret
; //----------------------------------------//    

Q1:      
    get_substr:
        mov ebp, esp; for correct debugging
        
        add esi, 7     ;início da substring
        
        mov edi, sub_str
        
        mov ecx, 41     ;quantidade de caracteres da substring
        rep movsb
        PRINT_STRING sub_str
        NEWLINE
        NEWLINE
    ret
 ; //----------------------------------------//   
    
;procedure da questao 2 aqui

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
    mov ecx, 42 ; começamos pegando o NULL Byte, por isso acrescentamos 1 no contador
    invert_str:
        mov ebp, esp; for correct debugging
        std     ;seta a direction flag para 1
        lodsb   ;le a partir do fim da string
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
        mov ebp, esp; for correct debugging
        lodsb
        cmp eax, 32     ;verifica se é espaço pelo código ascii
        je loop_remove_spaces     ;não armazena se for espaço
        stosb
        loop_remove_spaces:
        loop remove_spaces
        
        PRINT_STRING no_spaces_str
        NEWLINE
        NEWLINE
    ret
; //----------------------------------------//

Q5: 
    
    mov ebp,esp; for correct debugging
    mov esi,sub_str
    mov ecx,40
    mov edx,1 ; conta a os espaços entre as maísculas e minúsculas ao decorrer da frase
    mov ebx,0; conta a quantidade de vezes que aumentamos os espaços
    mov edi,0
    mov edi,upper_char_str
    cld
    catch_char:
        lodsb
        
        
        cmp eax,32 ;verifica se o caracter é um espaço
        je space
        
        cmp edx,1
        je upper_char
        
        cmp edx,0
        je upper_char
        
        dec edx
       
        stosb
        loop catch_char
        NEWLINE
        PRINT_STRING upper_char_str
        NEWLINE
        NEWLINE
        ret
    upper_char:
        sub eax,32
        stosb 
        
        cmp edx,0 ; signigfica que é a segunda letra maíuscula em sequência
        je next_lower_char
        
        dec edx
        dec ecx
        
        jmp catch_char
    
    next_lower_char:
        mov edx,4
        add edx,ebx ; adicionamos ao contador de espaços a qnt. de vezes que aumentamos a distancia para sempre aumentar em 1
        
        dec ecx
        inc ebx
        jmp catch_char
           
    space:
        dec ecx
        stosb
        jmp catch_char
    
          
     
   
   
    
    

; //----------------------------------------//
Q6:
    mov ecx, 36
    mov esi, no_spaces_str
    get_pos_in_alphabet:
        lodsb                  
        PRINT_CHAR eax
        PRINT_STRING " -> "
        sub eax,96             ;subtrai da letra de acordo com a tabela ASCII
        PRINT_DEC 1,eax
        NEWLINE
        dec ecx
        jnz get_pos_in_alphabet             ;loop no procedure até percorrer toda a string
    ret
; //----------------------------------------//


Q7:
    ret
