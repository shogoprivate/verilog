module CLOCK24(CLK, RST, nBUTTON, nHEX0, nHEX1, nHEX2, nHEX3, LEDG);

	input CLK, RST;
	input [2:0] nBUTTON;
	output [6:0] nHEX0, nHEX1, nHEX2, nHEX3;
	output [7:0] LEDG;

	wire mode, select, adjust;
	wire en1hz, sig2hz;
	wire secclr, mininc, hourinc;
	wire secon, minon, houron1, houron10;
	wire [3:0] sec1, min1, hour1;
	wire [2:0] sec10, min10;
	wire [1:0] hour10;
	wire casec, camin;

	BTN_IN BTN_IN(CLK, RST, nBUTTON, {mode, select, adjust});
	CNT1SEC CNT1SEC(CLK, RST, en1hz, sig2hz);
	STATE STATE(CLK, RST, sig2hz, hour1, hour10, mode, select, adjust, 
							secclr, mininc, hourinc, secon, minon, houron1, houron10);
	SECCNT SECCNT(CLK, RST, en1hz, secclr, sec1, sec10, casec);
	MINCNT MINCNT(CLK, RST, casec, mininc, min1, min10, camin);
	HOURCNT HOURCNT(CLK, RST, camin, hourinc, hour1, hour10);
	SEG7DEC MIN1DEC(minon, min1, nHEX0);
	SEG7DEC MIN10DEC(minon, min10, nHEX1);
	SEG7DEC HOUR1DEC(houron1, hour1, nHEX2);
	SEG7DEC HOUR10DEC(houron10, hour10, nHEX3);

	assign LEDG[3:0] = (secon==1'b1) ? sec1 : 4'h0;
	assign LEDG[6:4] = (secon==1'b1) ? sec10 : 3'h0;
	assign LEDG[7] = 1'h0;

endmodule
