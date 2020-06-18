/*module memoriaDeDados(data, saida, addr0, DataType, EscMen, LerMen, clk);
//parameter DATA_WIDTH=8, ADDR_WIDTH=12;

input [31:0] data;
input [7:0] addr0;
input EscMen, LerMen, clk;
input[1:0] DataType;
output[31:0] saida;

reg[31:0] out;
reg [7:0] ram[127:0];

wire[7:0] addr1, addr2, addr3;

assign saida = out;
assign addr1 = addr0 + 8'b1;
assign addr2 = addr1 + 8'b1;
assign addr3 = addr2 + 8'b1;

always @ (negedge clk)
begin
	if (EscMen)
	begin
		if(DataType == 2'b00 || DataType == 2'b11)
		begin
			ram[addr3] <= data[31:24];
			ram[addr2] <= data[23:16];
			ram[addr1] <= data[15:8];
			ram[addr0] <= data[7:0];
		end
		else if(DataType == 2'b01)
		begin
			ram[addr1] <= data[15:8]; 
			ram[addr0] <= data[7:0];
		end
		else if(DataType == 2'b10)
		begin
			ram[addr0] <= data[7:0];
		end
	end	
end

always @ (posedge clk)
begin
	if(LerMen)
	begin
		if(DataType[0])
		begin
			out = {16'b0, ram[addr1], ram[addr0]};
		end
		else if(DataType[1])
		begin
			out = {24'b0, ram[addr0]};
		end
		else
		begin
			out = {ram[addr3], ram[addr2], ram[addr1], ram[addr0]};
		end
	end
end

endmodule*/

// Quartus Prime Verilog Template
// Simple Dual Port RAM with separate read/write addresses and
// separate read/write clocks

module memoriaDeDados
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=4)
(
	input [31:0] data,
	input [(ADDR_WIDTH-1):0] read_addr, write_addr,
	input we, read_clock, write_clock,
	output reg [(DATA_WIDTH-1):0] q
);
	
	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];
	
	always @ (negedge write_clock)
	begin
		// Write
		if (we)
				ram[write_addr] <= data;
	end
	
	always @ (posedge read_clock)
	begin
		// Read 
		q <= ram[read_addr];
	end
	
endmodule


