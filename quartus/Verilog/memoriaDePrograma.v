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
ram[0] = 32'b01000000001000000000000000001010;
ram[1] = 32'b01000000010000000000000000000010;
ram[2] = 32'b01000000011000000000000000000011;
ram[3] = 32'b01000000100000000000000000011011;
ram[4] = 32'b10000000100000000000000000001100;
ram[5] = 32'b10001100001000000000000000000000;
ram[6] = 32'b10001100010000000000000000000000;
ram[7] = 32'b10001100011000000000000000000000;
ram[8] = 32'b11111101111000010001000000000000;
ram[9] = 32'b10011100100000000000000000000000;
ram[10] = 32'b10011100101000000000000000000000;
ram[11] = 32'b10011100110000000000000000000000;
ram[12] = 32'b10010000111000000000000000001100;
ram[13] = 32'b11111101000001000010100000000000;
ram[14] = 32'b11111101001001010011000000000000;
ram[15] = 32'b11111101010001000011000000000000;
ram[16] = 32'b00000000000000000000000000000000;
ram[17] = 32'b01000000001000000000000000001010;
ram[18] = 32'b01000000010000000000010000000001;
ram[19] = 32'b01000000011000000000000000000011;
ram[20] = 32'b01000000100000000000000000101111;
ram[21] = 32'b01000000101000000000000001001001;
ram[22] = 32'b01000000110000000000000000010000;
ram[23] = 32'b10000000001000000000000000000000;
ram[24] = 32'b10000100010000000000000000000100;
ram[25] = 32'b10001000011000000000000000000110;
ram[26] = 32'b10010000111000000000000000000000;
ram[27] = 32'b10010101000000000000000000000100;
ram[28] = 32'b10011001001000000000000000000110;
ram[29] = 32'b01000001010000000000000000011110;
ram[30] = 32'b10000000100000000000000000011110;
ram[31] = 32'b10000000101000000000000000100010;
ram[32] = 32'b10000000110000000000000000100110;
ram[33] = 32'b10010001101000000000000000011110;
ram[34] = 32'b10010001100000000000000000100010;
ram[35] = 32'b10010001011000000000000000100110;
ram[36] = 32'b01000011101000000000000000011110;
ram[37] = 32'b01000000100000000000010000000001;
ram[38] = 32'b01000000101000000001111010111000;
ram[39] = 32'b01000000110000000000000011001001;
ram[40] = 32'b10100000100000000000000000000000;
ram[41] = 32'b10100000101000000000000000000100;
ram[42] = 32'b10100000110000000000000000001000;
ram[43] = 32'b10110001101000000000000000000000;
ram[44] = 32'b10110001100000000000000000000100;
ram[45] = 32'b10110001011000000000000000001000;

end

always @ (negedge clk)
begin
	saida = ram[read_addr];
	
	if (EscMen)
		ram[write_addr] = data;
end

endmodule
