%include "io.inc"

section .bss
sub_str resb 32
inverted_str resb 32
no_spaces_str resb 32

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor esi, esi
    xor edi, edi
   
; //----------------------------------------//    
      
get_substr:
    mov ebp, esp; for correct debugging
    mov esi, string
    add esi, 7     ;início da substring
    mov edi, sub_str
    mov ecx, 41     ;quantidade de caracteres da substring
    rep movsb
    PRINT_STRING sub_str
    NEWLINE
    NEWLINE
    
 ; //----------------------------------------//   
    
;procedure da questao 2 aqui

; //----------------------------------------//

    mov edi, inverted_str
    mov ecx, 42
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

; //----------------------------------------//

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

; //----------------------------------------//

;procedure da quesão 5 aqui

; //----------------------------------------//

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

; //----------------------------------------//
section .data
string db "Qual e a importancia da escola na democratizacao da sociedade"
