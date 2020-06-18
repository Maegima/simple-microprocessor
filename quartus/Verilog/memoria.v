module memoria(data, saida, write_addr, read_addr, EscMen, write_clock, read_clock);
parameter DATA_WIDTH=8, ADDR_WIDTH=6;
	input [(DATA_WIDTH-1):0] data;
	input [(ADDR_WIDTH-1):0] read_addr, write_addr;
	input EscMen, write_clock, read_clock;
	output reg [(DATA_WIDTH-1):0] saida;
	
	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];
	
	always @ (negedge write_clock)
	begin
		// Write
		if (EscMen)
			ram[write_addr] <= data;
	end
	
	always @ (posedge read_clock)
	begin
		// Read 
		saida <= ram[read_addr];
	end
	
endmodule
