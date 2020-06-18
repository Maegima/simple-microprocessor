module moduloSaidaSetSeg(data, d0, d1, d2, d3, d4, d5, d6, d7, ctrl, reset, clk);
input[31:0] data;
input ctrl, reset, clk;
output reg[6:0] d0, d1, d2, d3, d4, d5, d6, d7;

wire[31:0] disp[7:0];

assign disp[0] = data;
assign disp[1] = (disp[0]/10);
assign disp[2] = (disp[1]/10);
assign disp[3] = (disp[2]/10);
assign disp[4] = (disp[3]/10);
assign disp[5] = (disp[4]/10);
assign disp[6] = (disp[5]/10);
assign disp[7] = (disp[6]/10);

always @(negedge clk or negedge reset)
begin
	if(~reset) begin
		d0 = 7'b1111111;
		d1 = 7'b1111111;
		d2 = 7'b1111111;
		d3 = 7'b1111111;
		d4 = 7'b1111111;
		d5 = 7'b1111111;
		d6 = 7'b1111111;
		d7 = 7'b1111111;
	end
	else if(ctrl) begin	
		d0 = decod_BCD(disp[0]%10);
		d1 = decod_BCD(disp[1]%10);
		d2 = decod_BCD(disp[2]%10);
		d3 = decod_BCD(disp[3]%10);
		d4 = decod_BCD(disp[4]%10);
		d5 = decod_BCD(disp[5]%10);
		d6 = decod_BCD(disp[6]%10);
		d7 = decod_BCD(disp[7]%10);

	end
end

function automatic[6:0] decod_BCD;
	input[3:0] in;
	reg[6:0] display;
	begin
		case(in)
			4'd0:    display = 7'b1000000;
			4'd1:    display = 7'b1111001;
			4'd2:    display = 7'b0100100;
			4'd3:    display = 7'b0110000;
			4'd4:    display = 7'b0011001;
			4'd5:    display = 7'b0010010;
			4'd6:    display = 7'b0000010;
			4'd7:    display = 7'b1111000;
			4'd8:    display = 7'B0000000;
			4'd9:    display = 7'b0010000;
			default: display = 7'b1111111;
		endcase
		decod_BCD = display;
	end
endfunction

endmodule


