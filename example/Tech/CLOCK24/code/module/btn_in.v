module BTN_IN(CLK, RST, nBIN, BOUT);

	input CLK, RST;
	input [2:0] nBIN;
	output [2:0] BOUT;

	wire en40hz;
	wire [2:0] tmp;
	reg [20:0] cnt;
	reg [2:0] BOUT;
	reg [2:0] ff1, ff2;

	// 40Hz生成回路
	always @(posedge CLK, posedge RST) begin
		if (RST)
			cnt <= 21'b0;
		else if (en40hz)
			cnt <= 21'b0;
		else
			cnt <= cnt + 21'b1;
	end

	assign en40hz = (cnt==21'd1249999);

	// チャタリング除去回路
	always @(posedge CLK, posedge RST) begin
		if (RST) begin
			ff2 <= 3'b0;
			ff1 <= 3'b0;
		end
		else if (en40hz) begin
			ff2 <= ff1;
			ff1 <= nBIN; 
		end
	end

	assign tmp = ~ff1 & ff2 & {3{en40hz}};

	always @(posedge CLK, posedge RST) begin
		if (RST)
			BOUT <= 3'b0;
		else
			BOUT <= tmp;
	end

endmodule



