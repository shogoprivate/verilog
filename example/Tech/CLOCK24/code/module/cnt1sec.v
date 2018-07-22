module CNT1SEC(CLK, RST, EN1HZ, SIG2HZ);

	input CLK, RST;
	output EN1HZ;
	output SIG2HZ;

	reg [25:0] cnt;
	reg SIG2HZ;
	wire [23:0] cnt12499999;
	wire [24:0] cnt24999999;
	wire [25:0] cnt37499999;
	
	always @(posedge CLK, posedge RST) begin
		if (RST)
			cnt <= 26'd0;
		else if (cnt==26'd49999999)
			cnt <= 26'd0;
		else
			cnt <= cnt+1'b1;
	end

	assign EN1HZ = (cnt==26'd49999999);
	assign cnt12499999 = (cnt==24'd12499999);
	assign cnt24999999 = (cnt==25'd24999999);
	assign cnt37499999 = (cnt==26'd37499999);
		
	always @(posedge CLK, posedge RST) begin
		if (RST)
			SIG2HZ <= 1'b0;
		else if (cnt12499999 | cnt24999999 | cnt37499999 | EN1HZ)
			SIG2HZ <= ~SIG2HZ;
	end

endmodule
