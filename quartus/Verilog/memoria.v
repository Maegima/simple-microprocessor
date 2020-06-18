module memoria(data, saida, write_addr, read_addr, EscMen, clock);
parameter DATA_WIDTH=8, ADDR_WIDTH=6;
	input [(DATA_WIDTH-1):0] data;
	input [(ADDR_WIDTH-1):0] read_addr, write_addr;
	input EscMen, clock;
	output reg [(DATA_WIDTH-1):0] saida;
	
	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];
	
	always @ (negedge clock)
	begin
		// Write
		if (EscMen)
			ram[write_addr] <= data;
	end
	
	always @ (posedge clock)
	begin
		// Read 
		saida <= ram[read_addr];
	end
	
endmodule
