module STATE(CLK, RST, SIG2HZ, HOUR1, HOUR2, MODE, SELECT, ADJUST, 
	SECCLR, MININC, HOURINC, SECON, MINON, HOURON1, HOURON10);

	input CLK, RST;
	input SIG2HZ;
	input [3:0] HOUR1;
	input [1:0] HOUR2;
	input MODE, SELECT, ADJUST;
	output SECCLR, MININC, HOURINC;
	output SECON, MINON, HOURON1, HOURON10;

	reg [1:0] stateCur, stateNxt;
	parameter NORM=2'b00, SEC=2'b01, MIN=2'b10, HOUR=2'b11;

	assign SECCLR = (stateCur==SEC) & ADJUST;
	assign MININC = (stateCur==MIN) & ADJUST;
	assign HOURINC = (stateCur==HOUR) & ADJUST;
	
	assign SECON = ~((stateCur==SEC) & SIG2HZ);
	assign MINON = ~((stateCur==MIN) & SIG2HZ);
	assign HOURON1 = ~((stateCur==HOUR) & SIG2HZ);
	assign HOURON10 = ~(((stateCur==HOUR) & SIG2HZ) | ((stateCur==NORM) & (HOUR1<10) & (HOUR2<1)));

	always @(posedge CLK, posedge RST) begin
		if (RST)
			stateCur <= NORM;
		else 
			stateCur <= stateNxt;
	end

	always @* begin
		case(stateCur)
			NORM :begin
							if (MODE)
								stateNxt <= SEC;
							else
								stateNxt <= NORM;
						end
			SEC :begin
							if (MODE)
								stateNxt <= NORM;
							else if (SELECT)
								stateNxt <= MIN;
							else
								stateNxt <= SEC;
						end
			MIN :begin
							if (MODE)
								stateNxt <= NORM;
							else if (SELECT)
								stateNxt <= HOUR;
							else
								stateNxt <= MIN; 
						end
			HOUR :begin
							if (MODE)
								stateNxt <= NORM;
							else if (SELECT)
								stateNxt <= SEC;
							else
								stateNxt <= HOUR; 
						end
			default : stateNxt <= 2'bxx;
		endcase
	end

endmodule
