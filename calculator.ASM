format PE console

entry Start

include 'WIN32AX.INC'

section '.data' data readable writable

        ;?????????? ?????? ? ??????
        number1 db 10, 13, '1.Enter the number depending on the icon: 0:+, 1:-, 2:\, 3:*: ', 0

        number2 db 10, 13, '2.What you number?: ', 0

        number3 db 10, 13, '3.What you number?: ', 0

        formatFor db 10, 13, '%d', 0
        formatStr db 10, 13, '%d', 0
        formatNum db 10, 13, '%d', 0
        aszFmt  db  10, 13,  'Result: %d', 0Dh, 0Ah, 0
        aszFmt2  db  10, 13,  'Result: %d,', 0
        emptyStr  db '%d' , 0


        number11 rd 1
        number22 rd 2
        number33 rd 3

        C dd ?

        NULL = 0


section '.code' code readable writable

        Start:
Iol:
              ;???? ?????????? ? ?????????
              push number1
              call [printf]

              push number11
              push formatFor
              call [scanf]

              push number2
              call [printf]

              push number22
              push formatStr
              call [scanf]

              push number3
              call [printf]

              push number33
              push formatNum
              call [scanf]



              ;???????? ?????????? ????????????? ?????
              mov ebx, [number11]


              mov eax, 0
              cmp eax, ebx
                  jnl False3

              mov eax, 1
              cmp eax, ebx
                  jnl True2

              mov eax, 2
              cmp eax, ebx
                  jnl False

              mov eax, 3
              cmp eax, ebx
                  jnl True


True:   ;?????????
        mov ebx, [number22]
        imul ebx, [number33]

        push ebx
        cinvoke printf, aszFmt, ebx
        call [getch]
        jnl Iol

False:  ;???????
        mov eax, [number22]
        mov ecx, [number33]
        mov edx, 0

        div ecx
        mov [C], edx
        cinvoke printf, aszFmt2, eax
                ; ???? ????????? ???????
                mov ebx, 0
                lp:
                        mov eax, [C]
                        mov ecx, [number33]
                        imul eax, 10

                        mov edx, 0
                        div ecx
                        mov [C], edx

                        push eax
                        push emptyStr
                        call [printf]

                        add ebx,1
                        cmp ebx, 10
                jne lp
        jnl Iol



True2: ;?????????
        mov ebx, [number22]
        mov eax, [number33]

        sub ebx, eax
        push ebx
        cinvoke printf, aszFmt, ebx
        jnl Iol
        call [getch]


False3: ;?????
        mov ebx, [number22]
        mov eax, [number33]

        add ebx, eax
        push ebx
        cinvoke printf, aszFmt, ebx
        jnl Iol
        call [getch]


section '.idata' import data readable

        library kernel, 'kernel32.dll', \
                msvcrt, 'msvcrt.dll'
        import kernel, \
               ExitProcess, 'ExitProcess'

        import msvcrt,\
                printf, 'printf',\
                scanf, 'scanf', \
                getch, '_getch'