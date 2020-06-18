module memoriaDeDados2(data, saida, addr, EscMen, ReadMen, DataType, write_clock, read_clock);
parameter DATA_WIDTH=32, ADDR_WIDTH=8;
	input [(DATA_WIDTH-1):0] data;
	input [(ADDR_WIDTH-1):0] addr;
	input [1:0]DataType;
	input EscMen, ReadMen, write_clock, read_clock;
	output reg [(DATA_WIDTH-1):0] saida;
	
	reg [(DATA_WIDTH-1):0] dd;
	
	wire [7:0] s0, s1, s2, s3;
	wire [ADDR_WIDTH-3:0] addr0, addr1, addr2, addr3;
	wire EscMen0, EscMen1, EscMen2, EscMen3;
	
	wire [(DATA_WIDTH-1):0] data0;
	wire [3:0] esc;
	wire [1:0] selMen;
	
	assign selMen = addr[1:0];
	assign data0 = selMen[1] ? ( selMen[0] ? {data[7:0],data[31:8]} : {data[15:0],data[31:16]} ) : ( selMen[0] ? {data[23:0], data[31:24]} : data );
	
	assign esc = DataType[1] ? ( DataType[0] ? 4'hF : 4'h9 ) : ( DataType[0] ? 4'h1 : 4'hF );
	
	assign EscMen0 = esc[selMen];
	assign EscMen1 = esc[selMen+3];
	assign EscMen2 = esc[selMen+2];
	assign EscMen3 = esc[selMen+1];
	
	
	assign addr0 = addr[(ADDR_WIDTH-1):2] + |addr[1:0];
	assign addr1 =	addr[(ADDR_WIDTH-1):2] + &addr[1]; 
	assign addr2 = addr[(ADDR_WIDTH-1):2] + &addr[1:0];
	assign addr3 = addr[(ADDR_WIDTH-1):2];
	
	memoria m0(data0[7:0], s0, addr0, addr0, EscMen & EscMen0, write_clock, read_clock);
	
	memoria m1(data0[15:8], s1, addr1, addr1, EscMen & EscMen1, write_clock, read_clock);
	
	memoria m2(data0[23:16], s2, addr2, addr2, EscMen & EscMen2, write_clock, read_clock);
	
	memoria m3(data0[31:24], s3, addr3, addr3, EscMen & EscMen3, write_clock, read_clock);
	
always @(negedge read_clock)
begin
	dd = saida;
end
	
always @(ReadMen or DataType or addr[1:0] or read_clock or s0 or s1 or s2 or s3 or dd)
begin
	if(ReadMen & read_clock) 
	begin
		if(DataType == 2'b01)
			case(addr[1:0])
				2'b00: saida = {24'b0, s0};
				2'b01: saida = {24'b0, s1};
				2'b10: saida = {24'b0, s2};
				2'b11: saida = {24'b0, s3};
			endcase
		else if(DataType == 2'b10)
			case(addr[1:0])
				2'b00: saida = {16'b0, s1, s0};
				2'b01: saida = {16'b0, s2, s1};
				2'b10: saida = {16'b0, s3, s2};
				2'b11: saida = {16'b0, s0, s3};
			endcase
		else
			case(addr[1:0])
				2'b00: saida = {s3, s2, s1, s0};
				2'b01: saida = {s0, s3, s2, s1};
				2'b10: saida = {s1, s0, s3, s2};
				2'b11: saida = {s2, s1, s0, s3};
			endcase
	end
	else
		saida = dd;
end
endmodule
