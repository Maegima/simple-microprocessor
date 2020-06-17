module unidadeLogicaAritmetica(e0, e1, s0, s1, c0, seletor);
input[31:0] e0, e1;
input[5:0] seletor;
output[31:0] s0, s1;
output c0;

/*
parameter SOMA  = 5'b00000, SUBT  = 5'b00001, MULT  = 5'b00010, DIVI  = 5'b00011;
parameter OU	 = 5'b00100, NOU   = 5'b00101, E 	 = 5'b00110, NE	 = 5'b00111;
parameter OUEX  = 5'b01000, NOUX  = 5'b01001, MENOR = 5'b01010, MAIOR = 5'b01011;
parameter IGUAL = 5'b01100, SHLE  = 5'b01101, SHRI  = 5'b01110, DIFER = 5'b01111;
parameter MOVER = 5'b10000, NEGAR = 5'b10001, IMEDI = 5'b10010, IMEDI = 5'b10011;// O resto eh imedi
*/

wire[31:0] soma, subtracao, divisao, shiftleft, shiftright, resto;
wire[31:0] e, ou, ouex, negar, ne, nou, nouex;
wire[63:0] multiplicacao;
wire maior, menor, igual, diferente;

wire[31:0] multiplexador[4:0];

assign soma             	 	= e0 +  e1;
assign subtracao         		= e0 -  e1;
assign multiplicacao				= e0 *  e1;
assign divisao           		= e0 /  e1;
assign resto   	           	= e0 %  e1;
assign shiftleft         		= e0 << e1;
assign shiftright   	   	   = e0 >> e1;
assign e    		        	   = e0 &  e1;
assign ou                		= e0 |  e1;
assign ouex              		= e0 ^  e1;
assign negar    				   = ~e0;
assign ne    					   = ~(e0 & e1);
assign nou               		= ~(e0 | e1);
assign nouex             		= e0 ~^ e1;
assign maior             		= e0 >  e1;
assign menor             		= e0 <  e1;
assign igual             		= e0 == e1;
assign diferente         		= e0 != e1; 


//assign multiplexador[0] = seletor[1] ? (seletor[0] ? 11 : 10) : (seletor[0] ? 01 : 00);
assign multiplexador[0] = seletor[1] ? (seletor[0] ? divisao : multiplicacao[31:0]) : (seletor[0] ? subtracao : soma);
assign multiplexador[1] = seletor[1] ? (seletor[0] ? ne : e)                       : (seletor[0] ? nou : ou);
assign multiplexador[2] = seletor[1] ? (seletor[0] ? maior : menor)                : (seletor[0] ? nouex : ouex);
assign multiplexador[3] = seletor[1] ? (seletor[0] ? diferente : shiftright)       : (seletor[0] ? shiftleft : igual);
assign multiplexador[4] = seletor[1] ? e1                                          : (seletor[0] ? negar : e0);

assign c0 = (seletor[4:0] == 5'b01111) ? diferente : ((seletor[4:0] == 5'b01100) ? igual : ((seletor[4:1] == 4'b0101) ? (seletor[0] ? maior : menor) : 1'b0));  
assign s0 = seletor[4] ? multiplexador[4] : (seletor[3] ? (seletor[2] ? multiplexador[3] : multiplexador[2]) : (seletor[2] ? multiplexador[1] : multiplexador[0]));
assign s1 = (seletor[4:1] == 4'b0001) ? (seletor[0] ? resto : multiplicacao[63:32]) : 4'b0;

endmodule

