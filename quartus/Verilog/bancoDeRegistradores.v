module bancoDeRegistradores(RL0, RL1, RE0, esc0, esc1, comp, D0, D1, CM, AS, SP, JR, RF, ctrl, clk);

parameter LDREG=3'd1, LDHI=3'd2, LDLO=3'd3, LDTIME=3'd4, LDPTIME=3'd5, LDMULDIV = 3'd6, LDRF = 3'd7;

parameter EscReg1=3'd0, EscReg2=3'd1, Pilha1=3'd2, Pilha2=3'd3, EmpDesemp=3'd4;

input[4:0] RL0, RL1, RE0;
input[31:0] esc0, esc1;
input[7:0] ctrl;
input clk, comp;
output reg CM;
output reg[31:0] D0, D1, AS, SP, RF;
output[31:0] JR;

reg[31:0]Banco[31:0];
reg[31:0] HI, LO, TIME, PTIME;

initial
begin
	HI = 0; LO = 0; TIME = 65; PTIME = 123; AS = 0; SP = 0; RF = 73;
	//programa de teste
	//Banco[0] = 0;
	/*Banco[1] = 7;
	Banco[2] = 14;
	Banco[3] = 6;
	Banco[4] = 3;*/
end

assign JR = Banco[29];

always @(posedge clk)
begin
	case(ctrl[7:5])
		LDHI:
			D0 <= HI;
		LDLO:
			D0 <= LO;
		LDTIME:
			D0 <= TIME;
		LDPTIME:
			D0 <= PTIME;
		LDREG:
		begin
			D0 <= Banco[RL0];
			D1 <= Banco[RL1];
		end
		LDMULDIV:
		begin
			D0 <= Banco[RL0];
			D1 <= Banco[RL1];
		end
		default:
		begin
			D0 <= 0;
			D1 <= 0;
		end
	endcase
end

always @(negedge clk)
begin
	if(ctrl[7:5] == LDMULDIV)
	begin
		LO = esc0;
		HI = esc1;
	end
	else if(ctrl[7:5] == LDRF)
	begin
		RF = esc0;
	end
	else if(ctrl[EscReg2] & ~ctrl[EscReg1])
	begin
		if(LDHI == ctrl[7:5]) HI = esc1;
		if(LDLO == ctrl[7:5]) LO = esc1;
	end
	else if(~ctrl[EscReg2] & ctrl[EscReg1])
	begin
		if(RE0 != 0)
			Banco[RE0] = esc0;
	end
	else if(ctrl[EscReg2] & ctrl[EscReg1])
	begin
		CM = comp;
	end
	if(ctrl[Pilha2])
	begin
		SP = Banco[31];
		if(ctrl[EmpDesemp]) SP = SP + 4;
		else SP = SP - 4;
		Banco[31] = SP;
	end
	if(ctrl[Pilha1])
	begin
		AS = Banco[30];
		if(ctrl[EmpDesemp]) AS = AS + 4;
		else AS = AS - 4;
		Banco[30] = AS;
	end
end

endmodule
