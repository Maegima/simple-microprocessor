## [Índices](#sumário)
*  [1. Definição do Conjunto de Instruções](#1.-Definição-do-Conjunto-de-Instruções)
*  [2. Conjunto de instruções](#conjunto-de-instruções-1)
*  [3. Formato de Instruções](#formato-de-instruções-1)
	* [3.1 Tipo 1(Registrador)](#tipo-1registrador-1)
	*  [3.2 Tipo 2(Imediato 1)](#tipo-2imediato-1-1)
	*  [3.3 Tipo 3(Imediato 2)](#tipo-3imediato-2-1)
	*  [3.4 Tipo 4(Memória 1)](#tipo-4memória-1-1)
	*  [3.5 Tipo 5(Memória 2)](#tipo-5memória-2-1)
	*  [3.6 Tipo 6(Salto)](#tipo-6salto-1)
	*  [3.7 Tipo 7(Entrada/Saída)](#tipo-7entradasaída)
*  [4. Banco de Registradores](#banco-de-registradores-1)

# Definição do Conjunto de Instruções
* Opcode de 6 bits
* Instrução de 32 bits
* Operações com imediato e registrador
* Endereçamento Imediato, direto.
* Tipos de dados
	* inteiro 32 bits
	* natural 32 bits
	* caractere 8 bits
	* palavra 32 bits
	* meia palavra 16 bits
	* lógico 8 bits

# Conjunto de instruções
1. Soma
2. Subtração
3. Multiplicação R3
4. Divisão R3
5. Lógica ou
6. Lógica não ou
7. Lógica e
8. Lógica não e
9. Lógica ou exclusivo
10. Lógica não ou exclusivo
11. Menor que R3
12. Maior que R3
13. Mover
14. Deslocamento para direita
15. Deslocamento para esquerda
16. Obter tempo
17. Igual R3
18. Diferente R3
19. Multiplicação R2
20. Divisão R2
21. Mover de HI
22. Mover de LO
23. Obter tempo do programa
24. Igual R2
25. Diferente R2
26. Menor que R2
27. Maior que R2
28. Salto Registrador
29. Salto Registrador Condicional
30. Negar
31. Soma I com sinal
32. Subtração I com sinal
33. Multiplicação R2I com sinal
34. Divisão R2I com sinal
35. Lógica ou I
36. Lógica não ou I
37. Lógica e I
38. Lógica não e I
39. Lógica ou exclusivo I
40. Lógica não ou exclusivo I
41. Menor que I
42. Maior que I
43. Deslocamento para direita I
44. Deslocamento para esquerda I
45. Igual R2I
46. Diferente R2I
47. Soma I com sinal e overflow
48. Subtração I com sinal e overflow
49. Multiplicação RI com sinal
50. Divisão RI com sinal
51. Igual RI
52. Diferente RI
53. Menor que RI
54. Maior que RI
55. Carregar Imediato
56. Carregar
57. Carregar Meia Palavra
58. Carregar Byte
59. Empilhar
60. Descarregar
61. Descarregar Meia Palavra
62. Descarregar Byte
63. Desempilhar
64. Carregar RI
65. Carregar Meia Palavra RI
66. Carregar Byte RI
67. Descarregar RI
68. Descarregar Meia Palavra RI
69. Descarregar Byte RI
70. Salto
71. Salto condicional
72. Saltar e conectar
73. Saltar e desconectar
74. Entrada (registrador + Imediato)
75. Saída (saida + Imediato)
76. Dormir?  


# Formato de Instruções
## Tipo 1(Registrador)
***Opcode(6) | Reg(5) | Reg(5) ou NU(5) | Reg(5) ou NU(5) | NU(4) | Flags(2) ou NU(2) | OPEX(5)***
111111 R(5) X(10) NU(4) X(2) OPEX(5)

### 1. Soma
**Opcode(6) | Reg(5) | Reg(5) | Reg(5) | NU(4) | Flags(2) | OPEX(5)**
111111 R(5) S(5) T(5) NU(4) Flags(2) 00000

    Flag[0] = Com ou sem sinal, Flag[1] = Com ou sem overflow 
    (R, OV) <= (S) + (T)
    
### 2. Subtração 
**Opcode(6) | Reg(5) | Reg(5) | Reg(5) | NU(4) | Flags(2) | OPEX(5)**
111111 R(5) S(5) T(5) NU(4) Flags(2) 00001
    
    Flag[0] = Com ou sem sinal, Flag[1] = Com ou sem overflow 
    (R, OV) <= (S) - (T)

### 3. Multiplicação R3
**Opcode(6) | Reg(5) | Reg(5) | Reg(5) | NU(4) | Flags(2) | OPEX(5)**
111111 R(5) S(5) T(5) NU(4) Flags(2) 00010
	
	Flag[0] = Com ou sem sinal, Flag[1] = Não usado
    (R, HI) <= (S) * (T)  

### 4. Divisão R3
**Opcode(6) | Reg(5) | Reg(5) | Reg(5) | NU(4) | Flags(2) | OPEX(5)**
111111 R(5) S(5) T(5) NU(4) Flags(2) 00011

	Flag[0] = Com ou sem sinal, Flag[1] = Não usado
    (R, LO) <= (S) / (T)

### 5. Lógica ou
**Opcode(6) | Reg(5) | Reg(5) | Reg(5) | NU(6) | OPEX(5)**
111111 R(5) S(5) T(5) NU(6) 00100

    (R) <= (S) | (T)

 
### 6. Lógica não ou
**Opcode(6) | Reg(5) | Reg(5) | Reg(5) | NU(6) | OPEX(5)**
111111 R(5) S(5) T(5) NU(6) 00101

    (R) <= ~((S) | (T))

### 7. Lógica e
**Opcode(6) | Reg(5) | Reg(5) | Reg(5) | NU(6) | OPEX(5)**
111111 R(5) S(5) T(5) NU(6) 00110

    (R) <= (S) & (T)

### 8. Lógica não e
**Opcode(6) | Reg(5) | Reg(5) | Reg(5) | NU(6) | OPEX(5)**
111111 R(5) S(5) T(5) NU(6) 00111

    (R) <= ~((S) & (T))

### 9. Lógica ou exclusivo
**Opcode(6) | Reg(5) | Reg(5) | Reg(5) | NU(6) | OPEX(5)**
111111 R(5) S(5) T(5) NU(6) 01000

    (R) <= (S) ^ (T)

### 10. Lógica não ou exclusivo
**Opcode(6) | Reg(5) | Reg(5) | Reg(5) | NU(6) | OPEX(5)**
111111 R(5) S(5) T(5) NU(6) 01001

    (R) <= ((S) ^ (T))

### 11. Menor que R3
**Opcode(6) | Reg(5) | Reg(5) | Reg(5) | NU(6) | OPEX(5)**
111111 R(5) S(5) T(5) NU(6) 01010

    (R) <= (S) < (T)

### 12. Maior que R3
**Opcode(6) | Reg(5) | Reg(5) | Reg(5) | NU(6) | OPEX(5)**
111111 R(5) S(5) T(5) NU(6) 01011

    (R) <= (S) > (T)

### 13. Mover
**Opcode(6) | Reg(5) | Reg(5) | NU(11) | OPEX(5)**
111111 R(5) S(5) NU(11) 01100

    (R) <= (S)

### 14. Deslocamento para direita
**Opcode(6) | Reg(5) | Reg(5) | Reg(5) | NU(6) | OPEX(5)**
111111 R(5) S(5) T(5) NU(6) 01101

    (R) <= (S) >> (T)

### 15. Deslocamento para esquerda
**Opcode(6) | Reg(5) | Reg(5) | Reg(5) | NU(6) | OPEX(5)**
111111 R(5) S(5) T(5) NU(6) 01110

    (R) <= (S) << (T)

### 16. Obter tempo 
**Opcode(6) | Reg(5) | NU(16) | OPEX(5)**
111111 R(5) S(5) NU(16) 01111

    (R) <= (TM)

### 17. Igual R3
**Opcode(6) | Reg(5) | Reg(5) | Reg(5) | NU(6) | OPEX(5)**
111111 R(5) S(5) NU(11) 10000

    (R) <= (S) = (T)

### 18. Diferente R3
**Opcode(6) | Reg(5) | Reg(5) | Reg(5) | NU(6) | OPEX(5)**
111111 R(5) S(5) NU(11) 10001

    (R) <= (S) != (T)

### 19. Multiplicação R2
**Opcode(6) | Reg(5) | Reg(5) | NU(9) | Flags(2) | OPEX(5)**
111111 R(5) S(5) NU(9) Flags(2) 10010
	
	Flag[0] = Com ou sem sinal, Flag[1] = Não usado
    (LO, HI) <= (R) * (S)  

### 20. Divisão R2
**Opcode(6) | Reg(5) | Reg(5) | NU(9) | Flags(2) | OPEX(5)**
111111 R(5) S(5) NU(9) Flags(2) 10011
	
	Flag[0] = Com ou sem sinal, Flag[1] = Não usado
    (HI, LO) <= (R) / (S)

### 21. Mover de HI
**Opcode(6) | Reg(5) |  NU(16) | OPEX(5)**
111111 R(5) NU(16) 10100

    (R) <= (HI) 

### 22. Mover de LO
**Opcode(6) | Reg(5) |  NU(16) | OPEX(5)**
111111 R(5) NU(16) 10101

    (R) <= (LO)

### 23. Obter tempo do programa
 **Opcode(6) | Reg(5) |  NU(16) | OPEX(5)**
111111 R(5) NU(16) 10110

    (R) <= (TP)

### 25. Igual R2
**Opcode(6) | Reg(5) | Reg(5) | NU(11) | OPEX(5)**
111111 R(5) S(5) NU(11) 11000

    (R) <= (S) = (T)

### 26. Diferente R2
**Opcode(6) | Reg(5) | Reg(5) | NU(11) | OPEX(5)**
111111 R(5) S(5) NU(11) 11001

    (R) <= (S) != (T)

### 27. Menor que R2
**Opcode(6) | Reg(5) | Reg(5) | NU(11) | OPEX(5)**
111111 R(5) S(5) NU(11) 11010

    (CM) <= (R) < (S)

### 28. Maior que R2
**Opcode(6) | Reg(5) | Reg(5) | NU(11) | OPEX(5)**
111111 R(5) S(5) NU(11) 11011

    (CM) <= (R) > (S)

### 30. Salto Registrador
**Opcode(6) | Reg(5)  | NU(16) | OPEX(5)**
111111 R(5) NU(16) 11101

    (PC) <= (R)

### 31. Salto Registrador Condicional
**Opcode(6) | Reg(5) | NU(16) | OPEX(5)**
111111 R(5) NU(6) 11110

    se CM então : (PC) <= (R)

### 32. Negar
**Opcode(6) | Reg(5) | Reg(5) |  NU(11) | OPEX(5)**
111111 R(5) S(5) NU(11) 11111

    (R) <= ~(S) 

## Tipo 2(Imediato 1)
***Opcode(6) | Reg(5) | Reg(5) | IM(16)***
0XXXXX R(5) S(5) IM(16)

### 1. Soma I com sinal
**Opcode(6) | Reg(5) | Reg(5) |  IM(16)**
000000 R(5) S(5) IM(16)

    (R) <= (S) + IM[16]

### 2. Subtração I com sinal
**Opcode(6) | Reg(5) | Reg(5) |  IM(16)**
000001 R(5) S(5) IM(16)

    (R) <= (S) - IM[16]

### 3. Multiplicação R2I com sinal
**Opcode(6) | Reg(5) | Reg(5) |  IM(16)**
000010 R(5) S(5) IM(16)

    (R, HI) <= (S) * IM[16]

### 4. Divisão R2I com sinal
**Opcode(6) | Reg(5) | Reg(5) | IM(16)**
000011 R(5) S(5) IM(16)

    (R, LO) <= (S) / IM[16]

### 5. Lógica ou I
**Opcode(6) | Reg(5) | Reg(5) | IM(16)**
000100 R(5) S(5) IM(16)

    (R) <= (S) | IM[16]

### 6. Lógica não ou I
**Opcode(6) | Reg(5) | Reg(5) | IM(16)**
000101 R(5) S(5) IM(16)

    (R) <= ~((S) | IM[16])

### 7. Lógica e I
**Opcode(6) | Reg(5) | Reg(5) | IM(16)**
000110  R(5) S(5) IM(16)

    (R) <= (S) & IM[16]

### 8. Lógica não e I
**Opcode(6) | Reg(5) | Reg(5) | IM(16)**
000111 R(5) S(5) IM(16)

    (R) <= ~((S) & IM[16])

### 9. Lógica ou exclusivo I
**Opcode(6) | Reg(5) | Reg(5) | IM(16)**
001000 R(5) S(5) IM(16)

    (R) <= (S) ^ IM[16]

### 10. Lógica não ou exclusivo I
**Opcode(6) | Reg(5) | Reg(5) | IM(16)**
001001 R(5) S(5) IM(16)

    (R) <= ~((S) ^ IM[16])

### 11. Menor que I
**Opcode(6) | Reg(5) | Reg(5) | IM(16)**
001010 R(5) S(5) IM(16)

    (R) <= (S) < IM[16]

### 12. Maior que I
**Opcode(6) | Reg(5) | Reg(5) | IM(16)**
001011 R(5) S(5) IM(16)

    (R) <= (S) > IM[16]

### 14. Deslocamento para direita I
**Opcode(6) | Reg(5) | Reg(5) | IM(16)**
001101 R(5) S(5) IM(16)

    (R) <= (S) << IM[16]

### 15. Deslocamento para esquerda I
**Opcode(6) | Reg(5) | Reg(5) | IM(16)**
001110 R(5) S(5) IM(16)

### 17. Igual R2I
**Opcode(6) | Reg(5) | Reg(5) | IM(16)**
010000 R(5) S(5) IM(16)

    (R) <= (S) = IM[16]

### 18. Diferente R2I
**Opcode(6) | Reg(5) | Reg(5) | IM(16)**
010001 R(5) S(5) IM(16)

    (R) <= (S) != IM[16]
    
### 19. Soma I com sinal e overflow
**Opcode(6) | Reg(5) | Reg(5) | IM(16)**
010010 R(5) S(5) IM(16)

	(R, OV) <= (S) + IM[16]

### 20. Subtração I com sinal e overflow
**Opcode(6) | Reg(5) | Reg(5) | IM(16)**
010011 R(5) S(5) IM(16)

	(R, OV) <= (S) - IM[16]

## Tipo 3(Imediato 2)
***Opcode(6) | Reg(5) | IM(21)***
011XXX R(5) IM(21)

### 1. Multiplicação RI com sinal
**Opcode(6) | Reg(5) | IM(21)**
011000 R(5) IM(21)

    (LO, HI) <= (R) * IM[21]  

### 2. Divisão RI com sinal
**Opcode(6) | Reg(5) | IM(21)**
011001 R(5) IM(21)

    (HI, LO) <= (R) / IM[21]

### 3. Igual RI
**Opcode(6) | Reg(5) | IM(21)**
011010 R(5) IM(21)

    (CM) <= (R) = IM[21]

### 4. Diferente RI
**Opcode(6) | Reg(5) | IM(21)**
011011 R(5) IM(21)

    (CM) <= (S) != IM[21]

### 5. Menor que RI
**Opcode(6) | Reg(5) | IM(21)**
011100 R(5) IM(21)

    (CM) <= (R) < IM[21]

### 6. Maior que RI
**Opcode(6) | Reg(5) | IM(21)**
011101 R(5) IM(21)

    (CM) <= (R) > IM[21]

### 7. Carregar Imediato
**Opcode(6) | Reg(5) | IM(21)**
011110 R(5) IM(21)

    (R) <= IM[21]

## Tipo 4(Memória 1)
***Opcode(6) | Reg(5) | EN(21) ou NU(21)***
100XXX R(5) X(21)

### 1.  Carregar
**Opcode(6) | Reg(5)  | EN(21)**
100000 R(5) EN(21)

    MEMORIA[EN[21]] <= (R)

### 2.  Carregar Meia Palavra
**Opcode(6) | Reg(5) | EN(21)**
100001 R(5) EN(21)

    MEMORIA[EN[21]] <= MEIAPALAVRA((R))

### 3. Carregar Byte
**Opcode(6) | Reg(5) | EN(21)**
100010 R(5) EN(21)

    MEMORIA[EN[21]] <= BYTE((R))

### 4.  Empilhar
**Opcode(6) | Reg(5) | NU(21)**
100011 R(5) NU(21)

    MEMORIA[(SP)] <= (R) ; (SP) <= (SP) + 4

### 5.  Descarregar
**Opcode(6) | Reg(5) | EN(21)**
100100 R(5) EN(21)

    (R) <= MEMORIA[EN[21]]

### 6.  Descarregar Meia Palavra
**Opcode(6) | Reg(5) | EN(21)**
100101 R(5) EN(21)

    (R) <= MEIAPALAVRA(MEMORIA[EN[21]])

### 7. Descarregar Byte
**Opcode(6) | Reg(5) | EN(21)**
100110 R(5) EN(21)

    (R) <= BYTE(MEMORIA[EN[21]])

### 8. Desempilhar
**Opcode(6) | Reg(5) | NU(21)**
100111 R(5) NU(21)

    (R) <= MEMORIA[(SP)] ; (SP) <= (SP) - 4

## Tipo 5(Memória 2)
***Opcode(6) | Reg(5) | Reg(5) | IM(16)***
101XXX R(5) S(5) IM(16)

### 1.  Carregar RI
**Opcode(6) | Reg(5) | Reg(5)  | IM(16)**
101000 R(5) S(5) IM(16)

    MEMORIA[(S) + IM[16]] <= (R)

### 2.  Carregar Meia Palavra RI
**Opcode(6) | Reg(5) | Reg(5)  | IM(16)**
101001 R(5) S(5) IM(16)

    MEMORIA[(S) + IM[16]] <= MEIAPALAVRA((R))

### 3. Carregar Byte RI
**Opcode(6) | Reg(5) | Reg(5)  | IM(16)**
101010 R(5) S(5) IM(16)

    MEMORIA[(S) + IM[16]] <= BYTE((R))
    
### 5.  Descarregar RI
**Opcode(6) | Reg(5) | Reg(5)  | IM(16)**
101100 R(5) S(5) IM(16)

    (R) <= MEMORIA[(S) + IM[16]]

### 6.  Descarregar Meia Palavra RI
**Opcode(6) | Reg(5) | Reg(5)  | IM(16)**
101101 R(5) S(5) IM(16)

    (R) <= MEIAPALAVRA(MEMORIA[(S) + IM[16]])

### 7. Descarregar Byte RI
**Opcode(6) | Reg(5) | Reg(5)  | IM(16)**
101110 R(5) S(5) IM(16)

    (R) <= BYTE(MEMORIA[(S) + IM[16]])

## Tipo 6(Salto)
***Opcode(6) |  EN(26) ou NU(26)***
1100XX XXXXXXXXXXXXXXXXXXXXXXXXXXX

### 1.  Salto
**Opcode(6) |  EN(26)**
110000 EN(26)

    (PC) <= EN[26]

### 2.  Salto condicional
**Opcode(6) |  EN(26)**
110001 EN(26)

    se CM então : (PC) <= EN[26]

### 3.  Saltar e conectar
**Opcode(6) |  EN(26)**
110010 EN(26)

    MEMORIA[(AS)] <= (PC) ; (PC) <= EN[26] ; (AS) <= (AS) + 4

### 4. Saltar e desconectar

**Opcode(6) |  NU(26)**
110011 NU(26)

    (PC) <= MEMORIA[(AS)] ; (AS) = (AS) - 4

## Tipo 7(Entrada/Saída)
***Opcode(6) |  Reg(5) | NU(21)***
11110X XXXXXXXXXXXXXXXXXXXXXXXXXXX

### 1.  Entrada
**Opcode(6) | Reg(5) | NU(21) **
111100 | R(5) | NU(21)

	(R) <= (RE)

### 2.  Saída
**Opcode(6) | Reg(5) | NU(21) **
111101 | S(5) | NU(21)

	(RS) <= (R)



# Banco de Registradores

| Identificador | Nome                           | Sigla | Binário |
|---------------|--------------------------------|-------|---------|
| 0             | Zero                           | Zero  | 000000  |
| 1             | Registrador de propósito geral | PG0   | 000001  |
| 2             | Registrador de propósito geral | PG1   | 000010  |
| 3             | Registrador de propósito geral | PG2   | 000011  |
| 4             | Registrador de propósito geral | PG3   | 000100  |
| 5             | Registrador de propósito geral | PG4   | 000101  |
| 6             | Registrador de propósito geral | PG5   | 000110  |
| 7             | Registrador de propósito geral | PG6   | 000111  |
| 8             | Registrador de propósito geral | PG7   | 001000  |
| 9             | Registrador de propósito geral | PG8   | 001001  |
| 10            | Registrador de propósito geral | PG9   | 001010  |
| 11            | Registrador de propósito geral | PG10  | 001011  |
| 12            | Registrador de propósito geral | PG11  | 001100  |
| 13            | Registrador de propósito geral | PG12  | 001101  |
| 14            | Registrador de propósito geral | PG13  | 001110  |
| 15            | Registrador de propósito geral | PG14  | 001111  |
| 16            | Guardar Resultados             | V0    | 010000  |
| 17            | Guardar Resultados             | V1    | 010001  |
| 18            | Guardar Resultados             | V2    | 010010  |
| 19            | Guardar Resultados             | V3    | 010011  |
| 20            | Guarda Parametros              | A0    | 010100  |
| 21            | Guarda Parametros              | A1    | 010101  |
| 22            | Guarda Parametros              | A2    | 010110  |
| 23            | Guarda Parametros              | A3    | 010111  |
| 24            | Registrador de propósito geral | PG15  | 011000  |
| 25            | Registrador de propósito geral | PG16  | 011001  |
| 26            | Registrador de propósito geral | PG17  | 011010  |
| 27            | Registrador de propósito geral | PG18  | 011011  |
| 28            | Registrador de propósito geral | PG19  | 011100  |
| 29            | Registrador de propósito geral | PG20  | 011101  |
| 30            | Ponteiro da pilha              | SP    | 011110  |
| 31            | Ponteiro da pilha de função    | AS    | 011111  |
| 32            | Registrador HIGH               | HI    | 100001  |
| 33            | Registrador LOW                | LO    | 100010  |
| 34            | Registrador de comparação      | CM    | 100011  |
| 35            | Registrador de overflow        | OV    | 100100  |  
| 36			| Registrador de tempo			 | TM	 | 100101  |	
| 37			| Registrador de tempo do programa | TP  | 100110  |
| 38			| Contador do programa			   | PC  | 100111  |
| 39			| Registrador de entrada		   | RE  | 101000  |
| 40			| Registrador de saída			   | RS  | 101001  |

	

# Sumário
* ### [1. Definição do Conjunto de Instruções](#definição-do-conjunto-de-instruções)
* ### [2. Conjunto de instruções](#conjunto-de-instruções)
* ### [3. Formato de Instruções](#formato-de-instruções)
	* #### [3.1 Tipo 1(Registrador)](#tipo-1registrador)
		* [3.1.1 Soma](#1.-soma)
		* [3.1.2 Subtração](#2.-subtração)
		* [3.1.3 Multiplicação R3](#3.-multiplicação-r3)
		* [3.1.4 Divisão R3](#4.-divisão-r3)
		* [3.1.5 Lógica ou](#5.-lógica-ou)
		* [3.1.6 Lógica não ou](#6.-lógica-não-ou)
		* [3.1.7 Lógica e](#7.-lógica-e)
		* [3.1.8 Lógica não e](#8.-lógica-não-e)
		* [3.1.9 Lógica ou exclusivo](#9.-lógica-ou-exclusivo)
		* [3.1.10 Lógica não ou exclusivo](#10.-lógica-não-ou-exclusivo)
		* [3.1.11 Menor que R3](#11.-menor-que-r3)
		* [3.1.12 Maior que R3](#12.-maior-que-r3)
		* [3.1.13 Mover](#13.-mover)
		* [3.1.14 Deslocamento para direita](#14.-deslocamento-para-direita)
		* [3.1.15 Deslocamento para esquerda](#15.-deslocamento-para-esquerda)
		* [3.1.16 Obter tempo](#16.-obter-tempo)
		* [3.1.17 Igual R3](#17.-igual-r3)
		* [3.1.18 Diferente R3](#18.-diferente-r3)
		* [3.1.19 Multiplicação R2](#19.-multiplicação-r2)
		* [3.1.20 Divisão R2](#20.-divisão-r2)
		* [3.1.21 Mover de HI](#21.-mover-de-hi)
		* [3.1.22 Mover de LO](#22.-mover-de-lo)
		* [3.1.23 Obter tempo do programa](#23.-obter-tempo-do-programa)
		* [3.1.25 Igual R2](#25.-igual-r2)
		* [3.1.26 Diferente R2](#26.-diferente-r2)
		* [3.1.27 Menor que R2](#27.-menor-que-r2)
		* [3.1.28 Maior que R2](#28.-maior-que-r2)
		* [3.1.30 Salto Registrador](#30.-salto-registrador)
		* [3.1.31 Salto Registrador Condicional](#31.-salto-registrador-condicional)
		* [3.1.32 Negar](#32.-negar)
	* #### [3.2 Tipo 2(Imediato 1)](#tipo-2imediato-1)
		* [3.2.1 Soma I com sinal](#1.-soma-i-com-sinal)
		* [3.2.2 Subtração I com sinal](#2.-subtração-i-com-sinal)
		* [3.2.3 Multiplicação R2I com sinal](#3.-multiplicação-r2i-com-sinal)
		* [3.2.4 Divisão R2I com sinal](#4.-divisão-r2i-com-sinal)
		* [3.2.5 Lógica ou I](#5.-lógica-ou-i)
		* [3.2.6 Lógica não ou I](#6.-lógica-não-ou-i)
		* [3.2.7 Lógica e I](#7.-lógica-e-i)
		* [3.2.8 Lógica não e I](#8.-lógica-não-e-i)
		* [3.2.9 Lógica ou exclusivo I](#9.-lógica-ou-exclusivo-i)
		* [3.2.10 Lógica não ou exclusivo I](#10.-lógica-não-ou-exclusivo-i)
		* [3.2.11 Menor que I](#11.-menor-que-i)
		* [3.2.12 Maior que I](#12.-maior-que-i)
		* [3.2.14 Deslocamento para direita I](#14.-deslocamento-para-direita-i)
		* [3.2.15 Deslocamento para esquerda I](#15.-deslocamento-para-esquerda-i)
		* [3.2.17 Igual R2I](#17.-igual-r2i)
		* [3.2.18 Diferente R2I](#18.-diferente-r2i)
		* [3.2.19 Soma I com sinal e overflow](#19.-soma-i-com-sinal-e-overflow)
		* [3.2.20 Subtração I com sinal e overflow](#20.-subtração-i-com-sinal-e-overflow)
	* #### [3.3 Tipo 3(Imediato 2)](#tipo-3imediato-2)
		* [3.3.1 Multiplicação RI  com sinal](#1.-multiplicação-ri-com-sinal)
		* [3.3.2 Divisão RI  com sinal](#2.-divisão-ri-com-sinal)
		* [3.3.3 Igual RI](#3.-igual-ri)
		* [3.3.4 Diferente RI](#4.-diferente-ri)
		* [3.3.5 Menor que RI](#5.-menor-que-ri)
		* [3.3.6 Maior que RI](#6.-maior-que-ri)
		* [3.3.7 Carregar Imediato](#7.-carregar-imediato)
	* #### [3.4 Tipo 4(Memória 1)](#tipo-4memória-1)
		* [3.4.1 Carregar](#1.-carregar)
		* [3.4.2 Carregar Meia Palavra](#2.-carregar-meia-palavra)
		* [3.4.3 Carregar Byte](#3.-carregar-byte)
		* [3.4.4 Empilhar](#4.-empilhar)
		* [3.4.5 Descarregar](#5.-descarregar)
		* [3.4.6 Descarregar Meia Palavra](#6.-descarregar-meia-palavra)
		* [3.4.7 Descarregar Byte](#7.-descarregar-byte)
		* [3.4.8 Desempilhar](#8.-desempilhar)
	* #### [3.5 Tipo 6(Memória 2)](#tipo-5memória-2)
		* [3.5.1 Carregar RI](#1.-carregar-ri)
		* [3.5.2 Carregar Meia Palavra RI](#2.-carregar-meia-palavra-ri)
		* [3.5.3 Carregar Byte RI](#3.-carregar-byte-ri)
		* [3.5.5 Descarregar RI](#5.-descarregar-ri)
		* [3.5.6 Descarregar Meia Palavra RI](#6.-descarregar-meia-palavra-ri)
		* [3.5.7 Descarregar Byte RI](#7.-descarregar-byte-ri)
	* #### [3.6 Tipo 6(Salto)](#tipo-6salto)
		* [3.6.1 Salto](#1.-salto)
		* [3.6.2 Salto condicional](#2.-salto-condicional)
		* [3.6.3 Saltar e conectar](#3.-saltar-e-conectar)
		* [3.6.4 Saltar e desconectar](#4.-saltar-e-desconectar)
	* #### [3.7 Tipo 7(Entrada/Saída)](#tipo-7entradasaída)
		* [3.7.1 Salto](#1.-entrada)
		* [3.7.2 Salto condicional](#2.-saída)
* ### [4. Banco de Registradores](#banco-de-registradores)
<!--stackedit_data:
eyJoaXN0b3J5IjpbNTQwNjkzNzYxLDIxMzIzNzQwMzEsMTQyND
c0MzE0MCwxMjU4MjU3OTEyLDEyNTgyNTc5MTIsMTI4NDI2NDI1
MiwxMzAyNjkxMDA1LC04NDE4MTE0NjMsLTkyMzM2OTMzLDc1Nz
EwOTc4MSwxMjUzNzA1NjksLTE5MTM5NTA5NTEsLTE3ODU1MDk4
NjAsLTMzNjgyMDYxNywtMTI3NjUwNDM0OSwtMTAxODMzNTY1MC
wtMTM0ODYxMzgsLTEyMzQzMDAzNTksLTE3NzU0NzE5NDAsMTE4
NjU4OTUwNF19
-->