// Quartus Prime Verilog Template
// Simple Dual Port RAM with separate read/write addresses and
// single read/write clock

module memoriaDeDados(data, saida, addr0, DataType, EscMen, LerMen, clk);
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

endmodule
