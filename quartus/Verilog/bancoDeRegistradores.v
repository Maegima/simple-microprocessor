module bancoDeRegistradores(RL0, RL1, RE0, esc0, esc1, comp, D0, D1, CM, DL, AS, SP, JR, RF, ctrl, delay, reset, clk, clk0);

parameter LDREG=3'd1, LDHI=3'd2, LDLO=3'd3, LDTIME=3'd4, LDPTIME=3'd5, LDMULDIV = 3'd6, LDRF = 3'd7;

parameter EscReg1=3'd0, EscReg2=3'd1, Pilha1=3'd2, Pilha2=3'd3, EmpDesemp=3'd4;

input[4:0] RL0, RL1, RE0;
input[31:0] esc0, esc1;
input[7:0] ctrl;
input clk, comp, clk0, reset, delay;
output reg CM; 
output reg[31:0] D0, D1, RF;
output[31:0] JR, AS, SP;
output DL;

reg[31:0]Banco[31:0];
reg[31:0] HI, LO, TIME, PTIME, DTIME;
reg[15:0] count;

assign JR = Banco[29];
assign AS = Banco[30];
assign SP = Banco[31];
assign DL = (DTIME > TIME);

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

always @(negedge clk or negedge reset)
begin
	if(~reset)
	begin
		Banco[0] = 0;
		Banco[30] = 0;
		Banco[31] = 0;
		PTIME = 0;
	end
	else if(ctrl[7:5] == LDMULDIV)
	begin
		if(ctrl[EscReg2] & ctrl[EscReg1])
		begin
			PTIME = esc0;
		end
		else
		begin
			LO = esc0;
			HI = esc1;
		end
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
	else if(ctrl[Pilha2])
	begin
		if(ctrl[EmpDesemp]) Banco[31] = Banco[31] + 4;
		else Banco[31] = Banco[31] - 4;
	end
	else if(ctrl[Pilha1])
	begin
		if(ctrl[EmpDesemp]) Banco[30] = Banco[30] + 1;
		else Banco[30] = Banco[30] - 1;
	end
end

always @(posedge delay)
begin
	DTIME = TIME + PTIME;
end

always @(posedge clk0 or negedge reset)
begin
	if(~reset) begin
		TIME = 0;
		count = 0;
	end
	else begin
		count = count + 16'b1;
		if(count == 16'd50000) begin
			TIME = TIME + 1;
			count = 0;
		end
	end
end

endmodule
