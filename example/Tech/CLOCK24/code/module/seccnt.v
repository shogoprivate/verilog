module SECCNT(CLK, RST, EN, CLR, QL, QH, CA);

	input CLK, RST;
	input EN, CLR;
	output [3:0] QL;
	output [2:0] QH;
	output CA;

	reg [3:0] QL;
	reg [2:0] QH;

	always @(posedge CLK, posedge RST) begin
		if (RST)
			QL <= 4'd0;
		else if (CLR)
			QL <= 4'd0;
		else if (EN) begin
			if (QL==4'd9)
				QL <= 4'd0;
			else
				QL <= QL+1'b1;
		end
	end

	always @(posedge CLK, posedge RST) begin
		if (RST)
			QH <= 3'd0;
		else if (CLR)
			QH <= 3'd0;
		else if (EN==1'b1 && QL==4'd9) begin
			if (QH==3'd5)
				QH <= 3'd0;
			else
				QH <= QH+1'b1;
		end
	end

	assign CA = (QL==4'd9 && QH==3'd5 && EN==1'b1);

endmodule
