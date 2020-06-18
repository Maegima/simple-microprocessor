// Quartus Prime Verilog Template
// Simple Dual Port RAM with separate read/write addresses and
// single read/write clock

module memoriaDePrograma(data, saida, write_addr, read_addr, EscMen, clk);
parameter DATA_WIDTH=32, ADDR_WIDTH=8;


input [(DATA_WIDTH-1):0] data;
input [(ADDR_WIDTH-1):0] read_addr, write_addr;
input EscMen, clk;
output reg [(DATA_WIDTH-1):0] saida;

// Declare the RAM variable
reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];

initial
begin
	//$readmemb("memoriaDePrograma.txt", ram);
	//programa de teste
	/*ram[0] = 32'b0;
	ram[1] = {6'b111111, 5'd5, 5'd3, 5'd1, 11'b0};
	ram[2] = {6'b111111, 5'd6, 5'd4, 5'd2, 11'b0};
	ram[3] = {6'b111111, 5'd12, 5'd4, 5'd3, 11'b1};
	ram[4] = {6'b111111, 5'd7, 5'd6, 5'd5, 11'b0};
	ram[5] = {6'b111111, 5'd7, 5'd7, 5'd7, 11'b10000};
	ram[6] = {6'b111111, 5'd8, 5'd5, 5'd6, 11'd1};
	ram[7] = 32'b0;
	ram[8] = {6'b111111, 5'd1, 5'd3, 5'd0, 11'b11011};
	ram[9] = 32'b0;
	ram[10] = {6'b110001, 26'd50 };
	ram[50] = {6'b100000, 5'd7, 21'd12 };
	ram[51] = 32'b0;
	ram[52] = {6'b100100, 5'd13, 21'd12 };
	ram[53] = {6'b111111, 5'd14, 5'd13, 5'd3, 11'b0};
	ram[54] = {6'b000000, 5'd15, 5'd14, 16'd3};
	ram[55] = 32'b0;*/
ram[0] = 32'b11111100001000000000000000010100;
ram[1] = 32'b11110100001000000000000000000000;
ram[2] = 32'b11111100010000000000000000010101;
ram[3] = 32'b11110100010000000000000000000000;
ram[4] = 32'b01000000001000000000001111101000;
ram[5] = 32'b11110100001000000000000000000000;
ram[6] = 32'b01000000010000000001011101110000;
ram[7] = 32'b11110100010000000000000000000000;
ram[8] = 32'b11100100010000000000000000000000;
ram[9] = 32'b11100000000000000000000000000000;
ram[10] = 32'b11111100001000000000000000010100;
ram[11] = 32'b11110100001000000000000000000000;
ram[12] = 32'b11111100010000000000000000010101;
ram[13] = 32'b11110100010000000000000000000000;


end

always @ (negedge clk)
begin
	saida = ram[read_addr];
	
	if (EscMen)
		ram[write_addr] = data;
end

endmodule
