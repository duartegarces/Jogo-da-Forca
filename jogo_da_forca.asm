 ;Jogo da Forca (Duarte Garces e Ricardo Bessa)
include emu8086.inc 
ORG 100h
;apagar ecra
mov ax, 0003H
int 10H

    GOTOXY 20, 9
        MOV AH, 9
        LEA DX, RETANGULO
        INT 21H 
    GOTOXY 20, 10
        MOV AH, 9
        LEA DX, ASTERISCO
        INT 21H 
    GOTOXY 20, 11
        MOV AH, 9
        LEA DX, RETANGULO
        INT 21H      
    GOTOXY 56, 10
        MOV AH, 9
        LEA DX, ASTERISCO
        INT 21H    

GOTOXY 25, 10
PRINT 'Bem Vindo ao Jogo da Forca!  ' 

GOTOXY 0, 20  
PRINT 'Prima uma tecla qualquer'
CURSOROFF
 
;aguardar tecla do utilizador
    mov ah, 07h
    INT 21h
inicio:
;apagar ecra
mov ax, 0003H
int 10H

;MENU
PRINT 'ESCOLHE UM TEMA:'
GOTOXY 0, 1
PRINT '1-FUTEBOL'
GOTOXY 0, 2 
PRINT '2-ANIMAIS'
GOTOXY 0, 3
PRINT '3-COMIDA '
GOTOXY 0, 4

MOV AH, 1
INT 21H

MOV CL, AL
    
CMP CL, '2'
    JE GO2   
CMP CL, '1'
    JE GO1
CMP CL, '3'
    JE GO3
       
;#############################################################################################
;#                                                                                           #
;#                       TEMA: FUTEBOOOOOOOOOOOOOOOOOOOOL                                    #
;#                                                                                           #
;#############################################################################################    
GO1: 
mov ax, 0003H
    int 10H
    
 GOTOXY 15,0
   PRINT '     TEMA:     FUTEBOL    '      
   call construir_a_forca                             
 GOTOXY 0,0        
   call palavra_random

;PALAVRAS: BOLA, EQUIPA, JOGADORES, ARBITRO, PENALTI
    CMP ax, 1
    JE BOLA
    CMP ax, 2
    JE EQUIPA
    CMP ax, 3
    JE JOGADORES
    CMP ax, 4
    JE ARBITRO
    CMP ax, 5
    JE penalti
;######################################
;#                                    #
;#           BOLA                     #
;#                                    #
;###################################### 
BOLA:
    tente_letra db "QUAL A LETRA: $"  
    palavra db "bola$"
    descobrir_palavra db 4 dup("_"), "$"
    palavra_tam db 4   
    dw   128  dup(?)
         
main_loop:

    call    letradescartada
    GOTOXY 25, 4
        mov     ah, 9
        lea     dx, descobrir_palavra
        int     21h
    call    verificar
    
    GOTOXY 25, 6
        mov     ah, 9
        lea     dx, tente_letra
        int     21h
    call    ler_teclado  
    call    atualizar 
        loop    main_loop 
                 
verificar:                   
    mov     bl, vidas        
    mov     bh, erros
    cmp     bl, bh
        je      game_over
    mov     bl, palavra_tam
    mov     bh, acertos
    cmp     bl, bh
        je      game_win
    
    ret          
       
atualizar:  
    lea     si, palavra
    lea     di, descobrir_palavra     
    mov     bx, 0 
    
    atualizar_loop:
        cmp     [si], "$"
            je      end_word                                      
        ; check if letter is already taken   
        cmp     [di], al
            je      increment 
        ; check if letter is on the word    
        cmp     [si], al
            je      equals
                 
        increment:
            inc     si
            inc     di  
                jmp     atualizar_loop        
                    
        equals:
            mov     [di], al                 
            inc     acertos
            mov     bx, 1
                jmp     increment              
;######################################
;#                                    #
;#             EQUIPA                 #
;#                                    #
;######################################       
EQUIPA:
    tente_letra1 db "QUAL A LETRA: $"
    palavra1 db "equipa$"
    descobrir_palavra1 db 6 dup("_"), "$"
    palavra_tam1 db 6  
    dw   128  dup(?)
       
main_loop1:

    call    letradescartada
    GOTOXY 25, 4
        mov     ah, 9
        lea     dx, descobrir_palavra1
        int     21h
    call    verificar1
    
    GOTOXY 25, 6
        mov     ah, 9
        lea     dx, tente_letra1
        int     21h
    call    ler_teclado
    call    atualizar1
    loop    main_loop1 
           
 verificar1:                   
    mov     bl, vidas    
    mov     bh, erros
    cmp     bl, bh
        je      game_over
    mov     bl, palavra_tam1
    mov     bh, acertos 
    cmp     bl, bh
        je      game_win
    
    ret          
   
atualizar1:  
    lea     si, palavra1            
    lea     di, descobrir_palavra1     
    mov     bx, 0       
    atualizar_loop1:
        cmp     [si], "$"
            je      end_word
        ;check if letter is already taken
        cmp     [di], al
            je      increment1   
        ; check if letter is on the word    
        cmp     [si], al
            je      equals1
                 
    increment1:
        inc     si
        inc     di   
            jmp     atualizar_loop1              
    equals1:
        mov     [di], al
        inc     acertos
        mov     bx, 1
            jmp     increment1
               
;######################################
;#                                    #
;#          JOGADORES                 #
;#                                    #
;######################################    
JOGADORES:
    tente_letra2 db "QUAL A LETRA: $"
    palavra2 dw "jogadores$"
    descobrir_palavra2 db 9 dup("_"), "$"
    palavra_tam2 db 9  
    dw   128  dup(?)
         
main_loop2:

    call    letradescartada
    GOTOXY 25, 4
        mov     ah, 9
        lea     dx, descobrir_palavra2
        int     21h
        call    verificar2
    GOTOXY 25, 6
        mov     ah, 9
        lea     dx, tente_letra2
        int     21h
        call    ler_teclado
        call    atualizar2
    loop    main_loop2 
      
          
    verificar2:                   
    mov     bl, vidas  
    mov     bh, erros
    cmp     bl, bh
        je      game_over
    mov     bl, palavra_tam2
    mov     bh, acertos 
    cmp     bl, bh
        je      game_win
    
    ret          
    
atualizar2:  
    lea     si, palavra2            
    lea     di, descobrir_palavra2     
    mov     bx, 0
        
    atualizar_loop2:
        cmp     [si], "$"
            je      end_word
        ;check if letter is already taken
        cmp     [di], al
            je      increment2   
        ; check if letter is on the word    
        cmp     [si], al
            je      equals2
                 
    increment2:
    inc     si
    inc     di   
        jmp     atualizar_loop2    
                 
    equals2:
    mov     [di], al
    inc     acertos
    mov     bx, 1
        jmp     increment2
       
;######################################
;#                                    #
;#            ARBITRO                 #
;#                                    #
;###################################### 
ARBITRO:
    tente_letra3 db "QUAL A LETRA: $"
    palavra3 db "arbitro$"
    descobrir_palavra3 db 7 dup("_"), "$"
    palavra_tam3 db 7  
    dw   128  dup(?)     
main_loop3:
    call    letradescartada
    GOTOXY 25, 4
        mov     ah, 9
        lea     dx, descobrir_palavra3
        int     21h
    call    verificar3
    
    GOTOXY 25, 6
        mov     ah, 9
        lea     dx, tente_letra3
        int     21h
        call    ler_teclado
        call    atualizar3
    loop    main_loop3 
          
          
    verificar3:                   
        mov     bl, vidas    
        mov     bh, erros
        cmp     bl, bh
            je      game_over
        mov     bl, palavra_tam3
        mov     bh, acertos 
        cmp     bl, bh
            je      game_win  
    ret          
     
atualizar3:  
    lea     si, palavra3            
    lea     di, descobrir_palavra3     
    mov     bx, 0
        
    atualizar_loop3:
        cmp     [si], "$"
         je      end_word
    
        cmp     [di], al
         je      increment3
        ; check if letter is on the word    
        cmp     [si], al
         je      equals3
                 
        increment3:
            inc     si
            inc     di   
                jmp     atualizar_loop3    
                 
        equals3:
            mov     [di], al
            inc     acertos
            mov     bx, 1
                jmp     increment3

;######################################
;#                                    #
;#            PENALTI                 #
;#                                    #
;###################################### 
PENALTI:
    tente_letra4 db "QUAL A LETRA: $"
    palavra4 db "penalti$"
    descobrir_palavra4 db 7 dup("_"), "$"
    palavra_tam4 db 7  
    dw   128  dup(?)     
main_loop4:
    call    letradescartada
    GOTOXY 25, 4
        mov     ah, 9
        lea     dx, descobrir_palavra4
        int     21h
    call    verificar4
    
    GOTOXY 25, 6
        mov     ah, 9
        lea     dx, tente_letra4
        int     21h
    call    ler_teclado
    call    atualizar4
        loop    main_loop4 
          
          
    verificar4:                   
        mov     bl, vidas   
        mov     bh, erros
        cmp     bl, bh
            je      game_over
        mov     bl, palavra_tam4
        mov     bh, acertos
        cmp     bl, bh
            je      game_win
    ret          
    
atualizar4:  
    lea     si, palavra4            
    lea     di, descobrir_palavra4     
    mov     bx, 0
        
    atualizar_loop4:
        cmp     [si], "$"
            je      end_word   
 
        cmp     [di], al
            je      increment4    
       
        cmp     [si], al
            je      equals4
                 
        increment4:
            inc     si
            inc     di   
                jmp     atualizar_loop4    
                 
        equals4:
            mov     [di], al
            inc     acertos
            mov     bx, 1
            jmp     increment4
                
;aguardar tecla do utilizador
    mov ah, 07h
    INT 21h     
;#############################################################################################
;#                                                                                           #
;#                       TEMA: ANIMAISSSSSSSSSSSSSSSSSSSS                                    #
;#                                                                                           #
;############################################################################################# 
GO2:
    mov ax, 0003H
    int 10H     
    GOTOXY 15,0
        PRINT '     TEMA:     ANIMAIS    '        
    call construir_a_forca                        
    GOTOXY 0,0        
    call PALAVRA_RANDOM ;PALAVRAS: ELEFANTE; LEAO; HIPOPOTAMO; GIRAFA, PONEI    
    
    CMP ax, 1
        JE ELEFANTE
    CMP ax, 2
        JE LEAO
    CMP ax, 3
        JE TIGRE
    CMP ax, 4
        JE GIRAFA
    CMP ax, 5
        JE PONEI
;######################################
;#                                    #
;#            ELEFANTE                #
;#                                    #
;###################################### 
ELEFANTE:
    tente_letra5 db "QUAL A LETRA: $"
    palavra5 db "elefante$"
    descobrir_palavra5 db 8 dup("_"), "$"
    palavra_tam5 db 8  
    dw   128  dup(?)     
main_loop5:
    call    letradescartada
    GOTOXY 25, 4
        mov     ah, 9
        lea     dx, descobrir_palavra5
        int     21h
    call    verificar5 
    GOTOXY 25, 6
        mov     ah, 9
        lea     dx, tente_letra5
        int     21h
    call    ler_teclado
    call    atualizar5
        loop    main_loop5 
                    
    verificar5:                   
        mov     bl, vidas   
        mov     bh, erros
        cmp     bl, bh
            je      game_over
        mov     bl, palavra_tam5
        mov     bh, acertos   
        cmp     bl, bh
            je      game_win
    
        ret          
        
    atualizar5:  
        lea     si, palavra5            
        lea     di, descobrir_palavra5     
        mov     bx, 0
                
        atualizar_loop5:
            cmp     [si], "$"
                je      end_word
            ;check if letter is already taken
            cmp     [di], al
                je      increment5
            ; check if letter is on the word    
            cmp     [si], al
                je      equals5
                 
            increment5:
                inc     si
                inc     di   
                    jmp     atualizar_loop5    
                 
            equals5:
                mov     [di], al
                inc     acertos
                mov     bx, 1
                    jmp     increment5
    
;######################################
;#                                    #
;#            LEAO                    #
;#                                    #
;######################################  
LEAO:
    tente_letra6 db "QUAL A LETRA: $"
    palavra6 db "leao$"
    descobrir_palavra6 db 4 dup("_"), "$"
    palavra_tam6 db 4  
    dw   128  dup(?)     
main_loop6:
    call    letradescartada
    GOTOXY 25, 4
        mov     ah, 9
        lea     dx, descobrir_palavra6
        int     21h
 
    call    verificar6
    
    GOTOXY 25, 6
        mov     ah, 9
        lea     dx, tente_letra6
        int     21h
    call    ler_teclado
    call    atualizar6
        loop    main_loop6 
                    
    verificar6:                   
        mov     bl, vidas   
        mov     bh, erros
        cmp     bl, bh
            je      game_over
        mov     bl, palavra_tam6
        mov     bh, acertos
        cmp     bl, bh
            je      game_win    
        ret          
    
atualizar6:  
    lea     si, palavra6            
    lea     di, descobrir_palavra6     
    mov     bx, 0
        
    atualizar_loop6:
        cmp     [si], "$"
            je      end_word
        ;check if letter is already taken
        cmp     [di], al
            je      increment6
        ; check if letter is on the word    
        cmp     [si], al
            je      equals6
                 
        increment6:
            inc     si
            inc     di   
                jmp     atualizar_loop6    
                 
        equals6:
            mov     [di], al
            inc     acertos
            mov     bx, 1
                jmp     increment6
;######################################
;#                                    #
;#           TIGRE                    #
;#                                    #
;######################################
TIGRE:
    tente_letra7 db "QUAL A LETRA: $"
    palavra7 db "tigre$"
    descobrir_palavra7 db 5 dup("_"), "$"
    palavra_tam7 db 5  
         
main_loop7:
    call    letradescartada
    GOTOXY 25, 4
        mov     ah, 9
        lea     dx, descobrir_palavra7
        int     21h
        call    verificar7
    
    GOTOXY 25, 6
        mov     ah, 9
        lea     dx, tente_letra7
        int     21h
    call    ler_teclado
    call    atualizar7
        loop    main_loop7 
                    
    verificar7:                   
        mov     bl, vidas     
        mov     bh, erros
        cmp     bl, bh
            je      game_over
        mov     bl, palavra_tam7
        mov     bh, acertos
        cmp     bl, bh
            je      game_win    
    ret          
        
atualizar7:  
    lea     si, palavra7            
    lea     di, descobrir_palavra7     
    mov     bx, 0
        
    atualizar_loop7:
        cmp     [si], "$"
            je      end_word
    
        cmp     [di], al
            je      increment7
        
        cmp     [si], al
            je      equals7
                 
        increment7:
            inc     si
            inc     di   
                jmp     atualizar_loop7    
                 
        equals7:
            mov     [di], al
            inc     acertos
            mov     bx, 1
                jmp     increment7

;######################################
;#                                    #
;#            GIRAFA                  #
;#                                    #
;######################################
GIRAFA:
    tente_letra8 db "QUAL A LETRA: $"
    palavra8 db "girafa$"
    descobrir_palavra8 db 6 dup("_"), "$"
    palavra_tam8 db 6  
    dw   128  dup(?)     
main_loop8:
    call    letradescartada
    GOTOXY 25, 4
        mov     ah, 9
        lea     dx, descobrir_palavra8
        int     21h
    call    verificar8
    
    GOTOXY 25, 6
        mov     ah, 9
        lea     dx, tente_letra8
        int     21h
    call    ler_teclado
    call    atualizar8
        loop    main_loop8 
                   
    verificar8:                   
        mov     bl, vidas   
        mov     bh, erros
        cmp     bl, bh
            je      game_over
        mov     bl, palavra_tam8
        mov     bh, acertos
        cmp     bl, bh
            je      game_win
    ret          
        
atualizar8:  
    lea     si, palavra8            
    lea     di, descobrir_palavra8     
    mov     bx, 0
        
    atualizar_loop8:
        cmp     [si], "$"
            je      end_word
    
        cmp     [di], al
            je      increment8
        
        cmp     [si], al
            je      equals8
                 
        increment8:
            inc     si
            inc     di   
                jmp     atualizar_loop8    
                 
        equals8:
        mov     [di], al
        inc     acertos
        mov     bx, 1
            jmp     increment8
;######################################
;#                                    #
;#             PONEI                  #
;#                                    #
;######################################
PONEI:
    tente_letra9 db "QUAL A LETRA: $"
    palavra9 db "ponei$"
    descobrir_palavra9 db 5 dup("_"), "$"
    palavra_tam9 db 5  
    dw   128  dup(?)     
main_loop9:
    call    letradescartada
    GOTOXY 25, 4
    mov     ah, 9
        lea     dx, descobrir_palavra9
        int     21h
    call    verificar9 
    GOTOXY 25, 6
        mov     ah, 9
        lea     dx, tente_letra9
        int     21h
    call    ler_teclado
    call    atualizar9
        loop    main_loop9 
                
    verificar9:                   
        mov     bl, vidas      
        mov     bh, erros
        cmp     bl, bh
            je      game_over
        mov     bl, palavra_tam9
        mov     bh, acertos 
        cmp     bl, bh
            je      game_win 
    ret          
       
    atualizar9:  
        lea     si, palavra9            
        lea     di, descobrir_palavra9     
        mov     bx, 0
        
        atualizar_loop9:
            cmp     [si], "$"
                je      end_word
            cmp     [di], al
                je      increment9
      
            cmp     [si], al
                je      equals9
                 
            increment9:
                inc     si
                inc     di   
                    jmp     atualizar_loop9    
                 
            equals9:
                mov     [di], al
                inc     acertos
                mov     bx, 1
                    jmp     increment9
    
;aguardar tecla do utilizador
    mov ah, 07h
    INT 21h      
;#############################################################################################
;#                                                                                           #
;#                       TEMA: COMIDAAAAAAAAAAAAAAAAAAAAA                                    #
;#                                                                                           #
;#############################################################################################                                  
GO3:
    mov ax, 0003H
    int 10H
    
    GOTOXY 15,0
        PRINT '     TEMA:     COMIDA    ' 
    call construir_a_forca 
                              
    GOTOXY 0,0        
    call palavra_random

;PALAVRAS: NUGGETS, BRIGADEIRO, LASANHA, ARROZ, BATATA
    CMP ax, 1
        JE NUGGETS
    CMP ax, 2
        JE BRIGADEIRO
    CMP ax, 3
        JE LASANHA
    CMP ax, 4
        JE ARROZ
    CMP ax, 5
        JE BATATA
    
;######################################
;#                                    #
;#           NUGGETS                  #
;#                                    #
;###################################### 
NUGGETS:    
    tente_letra10 db "QUAL A LETRA: $"  
    palavra10 db "nuggets$"
    descobrir_palavra10 db 7 dup("_"), "$"
    palavra_tam10 db 7       
    dw   128  dup(?)
         
main_loop10:
    call    letradescartada
    GOTOXY 25, 4
        mov     ah, 9
        lea     dx, descobrir_palavra10
        int     21h
    call    verificar10
    GOTOXY 25, 6
        mov     ah, 9
        lea     dx, tente_letra10
        int     21h
    call    ler_teclado     
    call    atualizar10     
        loop    main_loop10 
                    
verificar10:                   
    mov     bl, vidas  
    mov     bh, erros
    cmp     bl, bh
        je      game_over
    mov     bl, palavra_tam10
    mov     bh, acertos
    cmp     bl, bh
        je      game_win
    ret          
    
    
atualizar10:  
    lea     si, palavra10
    lea     di, descobrir_palavra10     
    mov     bx, 0 
    
    atualizar_loop10:
        cmp     [si], "$"
            je      end_word
                                            
        cmp     [di], al
            je      increment10
        
        cmp     [si], al
            je      equals10
                 
        increment10:
            inc     si
            inc     di     
                jmp     atualizar_loop        
                 
        equals10:
            mov     [di], al                 
            inc     acertos
            mov     bx, 1
                jmp     increment10                  
;######################################
;#                                    #
;#          BRIGADEIRO                #
;#                                    #
;######################################       
BRIGADEIRO:
    tente_letra11 db "QUAL A LETRA: $"
    palavra11 dw "brigadeiro$"
    descobrir_palavra11 db 10 dup("_"), "$"
    palavra_tam11 db 10  
    dw   128  dup(?)
main_loop11:
    call    letradescartada
    GOTOXY 25, 4
        mov     ah, 9
        lea     dx, descobrir_palavra11
        int     21h
    call    verificar11
    
    GOTOXY 25, 6
        mov     ah, 9
        lea     dx, tente_letra11
        int     21h
    call    ler_teclado
    call    atualizar11
    loop    main_loop11 
          
          
    verificar11:                   
        mov     bl, vidas     
        mov     bh, erros
        cmp     bl, bh
            je      game_over
        mov     bl, palavra_tam11
        mov     bh, acertos
        cmp     bl, bh
            je      game_win
    ret          
   
atualizar11:  
    lea     si, palavra11            
    lea     di, descobrir_palavra11     
    mov     bx, 0
        
    atualizar_loop11:
        cmp     [si], "$"
            je      end_word
        cmp     [di], al
            je      increment11    
        cmp     [si], al
            je      equals11
                 
        increment11:
            inc     si
            inc     di   
                jmp     atualizar_loop11    
                 
        equals11:
            mov     [di], al
            inc     acertos
            mov     bx, 1
                jmp     increment11
         
;######################################
;#                                    #
;#            LASANHA                 #
;#                                    #
;######################################    
LASANHA:
    tente_letra12 db "QUAL A LETRA: $"
    palavra12 db "lasanha$"
    descobrir_palavra12 db 7 dup("_"), "$"
    palavra_tam12 db 7  
    dw   128  dup(?)
         
main_loop12:
    call    letradescartada
    GOTOXY 25, 4
        mov     ah, 9
        lea     dx, descobrir_palavra12
        int     21h
    call    verificar12
    
    GOTOXY 25, 6
        mov     ah, 9
        lea     dx, tente_letra12
        int     21h
    call    ler_teclado
    call    atualizar12
        loop    main_loop12 
                    
    verificar12:                   
        mov     bl, vidas
        mov     bh, erros
        cmp     bl, bh
            je      game_over
        mov     bl, palavra_tam12
        mov     bh, acertos
        cmp     bl, bh
            je      game_win
    ret          
    
    
atualizar12:  
    lea     si, palavra12            
    lea     di, descobrir_palavra12     
    mov     bx, 0
        
    atualizar_loop12:
        cmp     [si], "$"
            je      end_word
    
        cmp     [di], al
            je      increment12    
        
        cmp     [si], al
            je      equals12
                 
        increment12:
            inc     si
            inc     di   
                jmp     atualizar_loop12    
                 
        equals12:
            mov     [di], al
            inc     acertos
            mov     bx, 1
                jmp     increment12
       
;######################################
;#                                    #
;#            ARROZ                   #
;#                                    #
;###################################### 
ARROZ:
    tente_letra13 db "QUAL A LETRA: $"
    palavra13 db "arroz$"
    descobrir_palavra13 db 5 dup("_"), "$"
    palavra_tam13 db 5  
    dw   128  dup(?)     
main_loop13:
    call    letradescartada
    GOTOXY 25, 4
        mov     ah, 9
        lea     dx, descobrir_palavra13
        int     21h
    call    verificar13
    GOTOXY 25, 6
        mov     ah, 9
        lea     dx, tente_letra13
        int     21h
    call    ler_teclado
    call    atualizar13
        loop    main_loop13           
          
    verificar13:                   
        mov     bl, vidas    
        mov     bh, erros
        cmp     bl, bh
            je      game_over
        mov     bl, palavra_tam13
        mov     bh, acertos 
        cmp     bl, bh
            je      game_win
    ret          
        
atualizar13:  
    lea     si, palavra13            
    lea     di, descobrir_palavra13     
    mov     bx, 0
        
    atualizar_loop13:
        cmp     [si], "$"
            je      end_word
            
        cmp     [di], al
            je      increment13
       
        cmp     [si], al
            je      equals13
                 
        increment13:
            inc     si
            inc     di   
                jmp     atualizar_loop13    
                 
        equals13:
            mov     [di], al
            inc     acertos
            mov     bx, 1
                jmp     increment13
;######################################
;#                                    #
;#           BATATA                   #
;#                                    #
;###################################### 
BATATA:
    tente_letra14 db "QUAL A LETRA: $"
    palavra14 db "batata$"
    descobrir_palavra14 db 6 dup("_"), "$"
    palavra_tam14 db 6  
    dw   128  dup(?)     
main_loop14:
    call    letradescartada
    GOTOXY 25, 4
        mov     ah, 9
        lea     dx, descobrir_palavra14
        int     21h
    call    verificar14
    
    GOTOXY 25, 6
        mov     ah, 9
        lea     dx, tente_letra14
        int     21h
    call    ler_teclado
    call    atualizar14
    loop    main_loop14 
                  
    verificar14:                   
        mov     bl, vidas      
        mov     bh, erros
        cmp     bl, bh
            je      game_over
        mov     bl, palavra_tam14
        mov     bh, acertos
        cmp     bl, bh
            je      game_win
        ret             
    
atualizar14:  
    lea     si, palavra14            
    lea     di, descobrir_palavra14     
    mov     bx, 0
        
    atualizar_loop14:
        cmp     [si], "$"
            je      end_word
    
        cmp     [di], al
            je      increment14
        
        cmp     [si], al
            je      equals14
                 
        increment14:
            inc     si
            inc     di   
                jmp     atualizar_loop14    
                 
        equals14:
            mov     [di], al
            inc     acertos
            mov     bx, 1
                jmp     increment14
         
   ;aguardar tecla do utilizador
        mov ah, 07h
        INT 21h      
   ;VARIAVEIS E FUNCOES UNIVERSAIS 
       DEFINE_PRINT_NUM_UNS 
       FORCABASE DB '------- $'
       FORCAPAU  DB '   |     ',10,13, '$'
       tronc  DB    '   |     |     ',10,13, '$'
       BRACOESQ DB '\$'
       BRACODIR DB '/$'
       ESPA€OLETRAS DB '_$'
       LETRAS_USADAS DB ' LETRAS JOGADAS: $'
       RETANGULO DB '************************************* $'
       RETANGULO1 DB '*************************************************$'  
       ASTERISCO DB '* $'    
       ASTERISCO2 DB '*                                               *',10,13,'                  ','$'   
       n db '                        ','$'
       nova_linha db 13, 10, "$"
       ganhou dw "YOU WIN!   $"
       perdeu dw "YOU LOSE!  $"
       vidas db 5                   
       acertos db 0
       erros db 0
       espacos db 20 
    
   CONSTRUIR_A_FORCA:
   ;BASE  
    GOTOXY 0,9
        MOV AH, 9
        LEA DX, FORCABASE
        INT 21H    
   ;ALTURA
    GOTOXY 0,3
        MOV CX, 6    
        
    REPETIR:       
            MOV AH, 9
            LEA DX, FORCAPAU
            INT 21H
        LOOP REPETIR    
    ;PARTE DE CIMA
    GOTOXY 3,2
        MOV AH, 9
        LEA DX, FORCABASE
        INT 21H    
    ;Retangulo Letras ja usadas
    GOTOXY 18,14
      MOV AH, 9
      LEA DX, RETANGULO1
      INT 21H
      
    GOTOXY 18,19
      MOV AH, 9
      LEA DX, RETANGULO1
      INT 21H
      
    GOTOXY 18,15
   
      MOV CX,4
    REPEAT:           
      MOV AH, 9
      LEA DX, ASTERISCO2
      INT 21H
      LOOP REPEAT
   
    GOTOXY 19,15
      MOV AH, 9
      LEA DX, LETRAS_USADAS
      INT 21H    
    ret 
      
  PALAVRA_RANDOM:
    xor ax,ax            ; xor register to itself same as zeroing register
    int 1ah              ; Int 1ah/ah=0 get timer ticks since midnight in CX:DX
    mov ax,dx            ; Use lower 16 bits (in DX) for random value
    
    xor dx,dx            ; Compute randval(DX) mod 10 to get num
    mov bx,5             ;     between 0 and 4
    div bx               ; Divide dx:ax by bx
    inc dx               ; DX = modulo from division
                         ;     Add 1 to give us # between 1 and 10 (not 0 to 9)
    mov ax,dx            ; Move to AX to print     
    call PRINT_NUM_UNS   ; Print value in AX as unsigned
    ret
 
 end_word:   
    cmp     bx, 1
        je      fim_atualizar
    call    letradescartada 
    inc     erros
    cmp     erros, 1
        je      corda
    cmp     erros, 2
        je      cabeca
    cmp     erros, 3
        je      tronco
    cmp     erros, 4
        je      bracos
    cmp     erros, 5
        je      pernas
    
 fim_atualizar:
    ret
    
 game_over: 
        lea     dx, perdeu
        call    print
            jmp     fim

 game_win:
        lea     dx, ganhou
        call    print
            jmp     fim
              
ler_teclado:  ; read keyborad and return in al
    mov     ah, 1
    int     21h
    ret 
letradescartada:
   mov di,0
   mov n[di], al
   inc di
   mov bl, espacos
   
   gotoxy bl,16   
   mov ah, 09
   lea dx, n
   int 21h
   inc bl
   mov espacos, bl
   ret   
    
print:
    GOTOXY 25, 4
    mov     ah, 9
    int     21h 
    ret

FIM:  
     mov ah, 07h
     INT 21h   
        jmp inicio 
errada:   
  call    letradescartada      
;############################### 
   corda:                ;######
    GOTOXY 6,3           ;######
    MOV AH, 9            ;######
    LEA DX, FORCAPAU     ;######
    INT 21H              ;######
    ret                  ;######
                         ;######
   cabeca:               ;######                 
    GOTOXY 6,3           ;######
     MOV AH, 9           ;######
     LEA DX, FORCAPAU    ;######
     INT 21H             ;######
    GOTOXY 9,4           ;######
     MOV AH, 6           ;######
     MOV DL, 1; print ?  ;######
     INT 21H             ;######
     ret                 ;######
                         ;######                        
   tronco:               ;######
    GOTOXY 6,3           ;######
     MOV AH, 9           ;######
     LEA DX, FORCAPAU    ;######
     INT 21H             ;######
    GOTOXY 9,4           ;######
     MOV AH, 6           ;######
     MOV DL, 1; print ?  ;######
     INT 21H             ;######
    GOTOXY 0,5           ;######
    MOV CX, 2            ;######
     repita:             ;######
         MOV AH, 9       ;######
         LEA DX, tronco  ;######
         INT 21H         ;######
         loop repita     ;######
     ret                 ;######
                         ;######
  bracos:                ;######
    GOTOXY 6,3           ;######
     MOV AH, 9           ;######
     LEA DX, FORCAPAU    ;######
     INT 21H             ;######
    GOTOXY 9,4           ;######
     MOV AH, 6           ;######
     MOV DL, 1; print ?  ;######
     INT 21H             ;######
    GOTOXY 0,5           ;######
     MOV CX, 2           ;######
     call  repita        ;######
    gotoxy 10,5          ;######
     MOV AH, 9           ;######
     LEA DX, bracoesq    ;######
     INT 21H             ;######
    gotoxy 8,5           ;######
     MOV AH, 9           ;######
     LEA DX, bracodir    ;######
     INT 21H             ;######
     ret                 ;######
                         ;######
  pernas:                ;######
    GOTOXY 6,3           ;######
     MOV AH, 9           ;######
     LEA DX, FORCAPAU    ;######
     INT 21H             ;######
    GOTOXY 9,4           ;######
     MOV AH, 6           ;######
     MOV DL, 1; print ?  ;######
     INT 21H             ;######
    GOTOXY 0,5           ;######
     MOV CX, 2           ;######
     call repita         ;######
    gotoxy 10,5          ;######
     MOV AH, 9           ;######
     LEA DX, bracoesq    ;######
     INT 21H             ;######
    gotoxy 8,5           ;######
     MOV AH, 9           ;######
     LEA DX, bracodir    ;######
     INT 21H             ;######
    gotoxy 10,7          ;######
     MOV AH, 9           ;######
     LEA DX, bracoesq    ;######
     INT 21H             ;######
    gotoxy 8,7           ;######
     MOV AH, 9           ;######
     LEA DX, bracodir    ;######
     INT 21H             ;######                     
     ret                 ;######                       
;###############################            
RET               ; return to operating system.
END               ; directive to stop the compiler.