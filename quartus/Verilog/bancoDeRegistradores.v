module bancoDeRegistradores(RL0, RL1, RE0, esc0, esc1, comp, D0, D1, CM, AS, SP, JR, RF, ctrl, clk);

parameter LDREG=3'd1, LDHI=3'd2, LDLO=3'd3, LDTIME=3'd4, LDPTIME=3'd5, LDMULDIV = 3'd6, LDRF = 3'd7;

parameter EscReg1=3'd0, EscReg2=3'd1, Pilha1=3'd2, Pilha2=3'd3, EmpDesemp=3'd4;

input[4:0] RL0, RL1, RE0;
input[31:0] esc0, esc1;
input[7:0] ctrl;
input clk, comp;
output reg CM;
output reg[31:0] D0, D1, RF;
output[31:0] JR, AS, SP;

reg[31:0]Banco[31:0];
reg[31:0] HI, LO, TIME, PTIME;

initial
begin
	HI = 0; LO = 0; TIME = 65; PTIME = 123; RF = 73;
end

assign JR = Banco[29];
assign AS = Banco[30];
assign SP = Banco[31];

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
		if(ctrl[EmpDesemp]) Banco[31] = Banco[31] + 4;
		else Banco[31] = Banco[31] - 4;
	end
	if(ctrl[Pilha1])
	begin
		if(ctrl[EmpDesemp]) Banco[30] = Banco[30] + 1;
		else Banco[30] = Banco[30] - 1;
	end
end

endmodule
