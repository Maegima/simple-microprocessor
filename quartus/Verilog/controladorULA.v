module controladorULA(opcode, opex, ctrl, s0);
input[5:0] opcode, opex;
input [3:0]ctrl;
output[5:0] s0;

wire[5:0] reg_inst, ime_inst;
wire[5:0] t1, t2, t3;

/*
parameter SOMA  = 5'b00000, SUBT  = 5'b00001, MULT  = 5'b00010, DIVI  = 5'b00011;
parameter OU	 = 5'b00100, NOU   = 5'b00101, E 	 = 5'b00110, NE	 = 5'b00111;
parameter OUEX  = 5'b01000, NOUX  = 5'b01001, MENOR = 5'b01010, MAIOR = 5'b01011;
parameter IGUAL = 5'b01100, SHLE  = 5'b01101, SHRI  = 5'b01110, DIFER = 5'b01111;
parameter MOVER = 5'b10000, NEGAR = 5'b10001, IMEDI = 5'b10010, IMEDI = 5'b10011;// O resto eh imedi
*/

assign reg_inst = (opex > 5'b10011 && opex < 5'b11010) ? 5'b10000 : ((opex < 5'b10010) ? {1'b0 ,opex[4:0]} : {2'b0 ,opex[3:0]}); // mover registrador ou operação ULA
assign ime_inst = (opcode[4:1] == 4'b1000) ? 5'b11111 : {2'b0 ,opcode[3:0]}; // carregar imediato ou operação ULA

assign t1 = ctrl[2] ? ime_inst : reg_inst; // imediato ou registrador
assign t2 = (opcode[5:4] == 2'b10 | opcode[5:3] == 3'b110 ) ? 5'b11111 : t1; // memoria/salto ou t1
assign t3 = ctrl[3] ? 5'b00000 : t2;       // deslocamento ou t2
assign s0 = (ctrl[0] | ctrl[1]) ? 5'b11111 : t3; // salto/desvio ou t3

endmodule
