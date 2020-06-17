module pilha(data, read_addr, write_addr, EscMen, clk, saida);
parameter DATA_WIDTH=32, ADDR_WIDTH=8;


input [(DATA_WIDTH-1):0] data;
input [(ADDR_WIDTH-1):0] read_addr, write_addr;
input EscMen, clk;
output reg [(DATA_WIDTH-1):0] saida;

reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];

always @ (posedge clk)
begin
	if (EscMen)
		ram[write_addr] <= data;

		saida <= ram[read_addr];
end

endmodule
