module processador(clk, ctrl1, ctrl2, ctrl3, PC, d0, d1, CM, instruction, s0, s1, e1_ula, e0_ula, s0_men, RF);
input clk;
output[7:0] ctrl1;
output[4:0] ctrl2;
output[4:0] ctrl3;

output reg[31:0] PC;
output CM;
output[31:0] d0, d1, instruction, e0_ula, e1_ula, s0, s1, s0_men;

reg[31:0] last_PC;

wire comp, cm, escPilha;
wire [7:0] pilha_read;
wire[31:0] JR, s0_ula, s1_ula, imediato, esc0_banc, SP, md_addr, s0_pilha, AS;
wire[5:0] operacao;
output[31:0] RF;

wire[31:0] load_addr, store_addr;

wire[4:0] reg1, reg2, reg3;

//parameter LDREG = 3'd01, LDHI    = 3'd02, LDLO   = 3'd03, LDTIME = 3'd04, LDPTIME   = 3'd05; 
parameter EmpDesemp = 3'd04, Pilha2  = 3'd03, Pilha1 = 3'd02, EscReg2 = 3'd01, EscReg1 = 3'd00; //ctrl1 
parameter MenReg    = 3'd04, LerReg3 = 3'd03, LerMen = 3'd02, EscMen  = 3'd01, RegIme  = 3'd00; //ctrl2
parameter Desloc    = 3'd04, ULAOp   = 3'd03, Salto  = 3'd02, Desvio  = 3'd01, ExSin   = 3'd00; //ctrl3

initial
begin
	PC = 0;
end

assign reg3 = instruction[25:21];
assign reg2 = ctrl2[LerReg3] ? instruction[25:21] : instruction[20:16];
assign reg1 = ctrl2[LerReg3] ? instruction[20:16] : instruction[15:11];   

assign s0 = clk ? s0_ula : s0;
assign s1 = clk ? s1_ula : s1;
assign cm = clk ? comp : cm;
assign e0_ula = ctrl3[Desloc] ? JR : d0;
assign e1_ula = ctrl2[RegIme] ? imediato : d1;

assign imediato = ctrl3[ExSin] ? {11'b0, instruction[20:0]} : {16'b0, instruction[15:0]};

assign esc0_banc = ctrl2[MenReg] ? s0_men : s0;

assign md_addr = ctrl2[LerMen] ? load_addr : store_addr; 

assign escPilha = ctrl1[EmpDesemp] & ctrl1[Pilha1];

assign pilha_read = AS[7:0] - 8'b1;

assign load_addr = ctrl1[Pilha2] ? SP - 32'd4 : s0_ula;

assign store_addr = ctrl1[Pilha2] ? SP : s0;

//memoriaDePrograma(data, saida, write_addr, read_addr, EscMen, clk);
memoriaDePrograma mp0(32'b0, instruction, 8'b0, PC[7:0], 1'b0, clk);

//pilha(data, saida, read_addr, write_addr, EscMen, clk);
pilha p0(last_PC + 1, s0_pilha, pilha_read, AS[7:0], escPilha, clk);

//module unidadeDeControle(opcode, opex,ctrl1, ctrl2, ctrl3, clk);
unidadeDeControle ctrl0(instruction[31:26], instruction[5:0], ctrl1, ctrl2, ctrl3);

//module controladorULA(opcode, opex, ctrl, s0);
controladorULA ctrlULA0(instruction[31:26], instruction[5:0], ctrl3[4:1], operacao);

//bancoDeRegistradores(RL0, RL1, RE0, esc0, esc1, comp, D0, D1, CM, AS, SP, ctrl, clk);
bancoDeRegistradores b0(reg2, reg1, reg3, esc0_banc, s1, cm, d0, d1, CM, AS, SP, JR, RF, ctrl1, clk);

//UnidadeLogicaAritmetica(e0, e1, s0, s1, c0, seletor);
unidadeLogicaAritmetica ula0(e0_ula, e1_ula, s0_ula, s1_ula, comp, operacao);

//memoriaDeDados2(data, saida, addr, EscMen, ReadMen, DataType, write_clock, read_clock);
memoriaDeDados2 md0(d0, s0_men, md_addr[5:0], ctrl2[EscMen], ctrl2[LerMen], instruction[27:26], clk, clk);

//memoriaDeDados(data, saida, addr, DataType, EscMen, LerMen, clk);
//memoriaDeDados md0(d0, s0_men, md_addr, instruction[27:26], ctrl2[EscMen], ctrl2[LerMen], clk);

always @(posedge clk)
begin
	last_PC = PC;
	if(ctrl1[7:5] == 3'b001)
	begin
		if(ctrl3[Salto])
			PC = JR;
		else if(ctrl3[Desvio] & CM)
			PC = JR;
		else
			PC = PC + 1;
	end
	else
	begin
		if(ctrl1[Pilha1])
		begin
			if(ctrl1[EmpDesemp])
				PC = {6'b0, instruction[25:0]};
			else
				PC = s0_pilha;
		end
		else if(ctrl3[Salto])
			PC = {6'b0, instruction[25:0]};
		else if(ctrl3[Desvio] & CM)
			PC = {6'b0, instruction[25:0]};
		else
			PC = PC + 1;
	end
end
endmodule
