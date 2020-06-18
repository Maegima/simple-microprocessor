module processador(clk, s0, s1, CM, switch, button, display, PC, instruction, s0_men, /*ctrl1, ctrl2, ctrl3, ctrl4,*/ d0, d1);
input clk;

output reg[31:0] display;
input[15:0] switch;
input[3:0] button;

output [31:0] s0, s1, s0_men;
output CM;
output reg[31:0] PC;
output[31:0] instruction;

reg[15:0] R_switch;
reg[31:0] last_PC;

wire [7:0] ctrl1;
wire [4:0] ctrl2;
wire [4:0] ctrl3;
wire [1:0] ctrl4;

wire[31:0] SP, AS, RF, JR;
output[31:0] d0, d1; 
wire[31:0] e0_ula, e1_ula, s0_ula, s1_ula;
wire[31:0] load_addr, store_addr, md_addr;
wire[31:0] imediato, esc0_banc; 
wire[31:0] s0_pilha, pilha_addr;

wire[5:0] operacao;

wire[4:0] reg1, reg2, reg3;

wire comp, cm, esc_pilha;

//parameter LDREG = 3'd01, LDHI    = 3'd02, LDLO   = 3'd03, LDTIME = 3'd04, LDPTIME   = 3'd05; 
parameter EmpDesemp = 3'd04, Pilha2  = 3'd03, Pilha1 = 3'd02, EscReg2 = 3'd01, EscReg1 = 3'd00; //ctrl1 
parameter MenReg    = 3'd04, LerReg3 = 3'd03, LerMen = 3'd02, EscMen  = 3'd01, RegIme  = 3'd00; //ctrl2
parameter Desloc    = 3'd04, ULAOp   = 3'd03, Salto  = 3'd02, Desvio  = 3'd01, ExSin   = 3'd00; //ctrl3
parameter Entrada   = 3'd01, Saida   = 3'd00; //ctrl4

initial
begin
	PC = 0;
end

// Seleciona registrador Escrita/Leitura
assign reg3 = instruction[25:21];
assign reg2 = ctrl2[LerReg3] ? instruction[25:21] : instruction[20:16];
assign reg1 = ctrl2[LerReg3] ? instruction[20:16] : instruction[15:11];  

// Entrada/Saida ULA
assign e0_ula = ctrl3[Desloc] ? JR : d0;
assign e1_ula = ctrl2[RegIme] ? imediato : d1;
assign s0 = clk ? s0_ula : s0;
assign s1 = clk ? s1_ula : s1;
assign cm = clk ? comp : cm;

// Enderecos de escrita/leitura memoria de dados 
assign load_addr = ctrl1[Pilha2] ? SP - 32'd4 : s0_ula;
assign store_addr = ctrl1[Pilha2] ? SP : s0;
assign md_addr = ctrl2[LerMen] ? load_addr : store_addr;

// Endereco de leitura pilha
assign pilha_addr = AS[7:0] - 8'b1;
assign esc_pilha = ctrl1[EmpDesemp] & ctrl1[Pilha1];

// Seleciona Extensor de bits 21 ou 16
assign imediato = ctrl3[ExSin] ? {11'b0, instruction[20:0]} : {16'b0, instruction[15:0]};

// Valor de Escrita banco de registradores
assign esc0_banc = ctrl2[MenReg] ? s0_men : ( ctrl4[Entrada] ? {16'b0, R_switch} : s0 );

//memoriaDePrograma(data, saida, write_addr, read_addr, EscMen, clk);
memoriaDePrograma mp0(32'b0, instruction, 8'b0, PC[7:0], 1'b0, clk);

//pilha(data, saida, read_addr, write_addr, EscMen, clk);
pilha p0(last_PC + 1, s0_pilha, pilha_addr[7:0], AS[7:0], esc_pilha, clk);

//module unidadeDeControle(opcode, opex,ctrl1, ctrl2, ctrl3, clk);
unidadeDeControle ctrl0(instruction[31:26], instruction[5:0], ctrl1, ctrl2, ctrl3, ctrl4);

//module controladorULA(opcode, opex, ctrl, s0);
controladorULA ctrlULA0(instruction[31:26], instruction[5:0], ctrl3[4:1], operacao);

//bancoDeRegistradores(RL0, RL1, RE0, esc0, esc1, comp, D0, D1, CM, AS, SP, ctrl, clk);
bancoDeRegistradores b0(reg2, reg1, reg3, esc0_banc, s1, cm, d0, d1, CM, AS, SP, JR, RF, ctrl1, clk);

//UnidadeLogicaAritmetica(e0, e1, s0, s1, c0, seletor);
unidadeLogicaAritmetica ula0(e0_ula, e1_ula, s0_ula, s1_ula, comp, operacao);

//memoriaDeDados2(data, saida, addr, EscMen, ReadMen, DataType, write_clock, read_clock);
memoriaDeDados2 md0(d0, s0_men, md_addr[13:0], ctrl2[EscMen], ctrl2[LerMen], instruction[27:26], clk, clk);

always @(negedge clk)
begin
	if(ctrl4[Saida])
		display = d0;
end

always @(posedge clk)
begin
	last_PC = PC;
	if(ctrl1[7:5] == 3'b001)
	begin
		if(ctrl3[Salto])
			PC = JR;
		else if(ctrl3[Desvio] & CM)
			PC = JR;
		else if(button[3])
			PC = 0;
		else if(ctrl4[Entrada])
		begin
			if(button[0])
			begin
				R_switch = switch;
				PC = PC + 1;
			end
		end
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
		else if(button[3])
			PC = 67;
		else
			PC = PC + 1;
	end
end
endmodule
