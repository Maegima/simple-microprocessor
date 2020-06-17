module unidadeDeControle(opcode, opex,ctrl1, ctrl2, ctrl3);
input[5:0] opcode, opex;
output[7:0] ctrl1; //reg
output[4:0] ctrl2; //reg
output[4:0] ctrl3; //reg

parameter LDREG = 3'd01, LDHI = 3'd02, LDLO = 3'd03, LDTIME = 3'd04, LDPTIME = 3'd05, LDMULDIV = 3'd06, LDRF = 3'd07;

reg [2:0] RegSelect; 
reg[1:0] Pilha, EscReg;
reg EmpDesemp; //ctrl1
reg MenReg, LerReg3, LerMen, EscMen; //ctrl2
reg Desloc, ULAOp, Salto, Desvio, ExSin; //ctrl3

wire[5:0] decode;
wire RegIme; 
assign RegIme = ~&opcode;

assign ctrl1 = {RegSelect, EmpDesemp, Pilha, EscReg};
assign ctrl2 = {MenReg, LerReg3, LerMen, EscMen, RegIme};
assign ctrl3 = {Desloc, ULAOp, Salto, Desvio, ExSin};
assign decode = (&opcode) ? opex : opcode; 

always @(decode or RegIme)
begin
	ULAOp = RegIme;
	EscReg = 2'b00; Pilha = 2'b00; EmpDesemp = 0;
	MenReg = 0; LerMen = 0; EscMen = 0;
	Desloc = 0; Salto = 0; Desvio = 0; ExSin = 0;
	RegSelect = LDREG; LerReg3 = 0; 
	// Extensor de Sinal
	if(decode[5:3] == 3'b010 || decode[5:3] == 3'b100 || decode[5:3] == 3'b110)
		ExSin = 1;
	
	// Imediato / Registrador
	if(!decode[5:4] || decode[5:3] == 3'b010 || decode[5:2] == 4'b0111 || decode[5:1] == 5'b01101)
	begin	
		LerReg3 = (decode < 6'b010010)? 1'b0 : decode[4];
		if(&decode[4:2] || decode[4:1] == 4'b1101)
		begin
			EscReg = 2'b11;
			ExSin = 1;
		end
		else if(decode[4:1] == 4'b0001)
			EscReg = 2'b10;
		else
			EscReg = 2'b01;
		if(decode[4:1] == 4'b1001)
			RegSelect = LDMULDIV;
		else if(decode[4:1] == 4'b1010)
			RegSelect = decode[0] ? LDPTIME : LDTIME;
		else if(decode[4:1] == 4'b1011)
			RegSelect = decode[0] ? LDLO : LDHI;
		else if((decode[4:0] == 5'b10001) & RegIme)
			RegSelect = LDRF;
	end
	// Salto / Desvio
	if(decode[5:2] == 4'b1100 || decode[4:1] == 4'b1100)
	begin
		if(decode[5:2] == 4'b1100)
		begin
			RegSelect = 0;
		end
		if(decode[1])
		begin
			EscMen = ~decode[0];
			LerMen = decode[0];
			EscReg = decode[0];
			MenReg = decode[0];
		end
		Salto = ~decode[0];
		Desvio = decode[0];
		Pilha[0] = decode[1];
		EmpDesemp = decode[1] & ~decode[0];
	end
	
	// Memoria
	if(decode[5:4] == 3'b10)
	begin
		Desloc = decode[3];
		EscMen = ~decode[2];
		LerReg3 = ~decode[2];
		LerMen = decode[2];
		MenReg = decode[2];
		Pilha[1] = &decode[1:0];
		EscReg = decode[2];
		EmpDesemp = (&decode[1:0]) & ~decode[2];
	end
	
end


endmodule