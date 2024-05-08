
`timescale 1ns / 1ps
module botun_text(
	input key1,key2,key3,key4,
	input clk,rst_n,
	input video_on,
	input[9:0] pixel_x,pixel_y,
	input[2:0] winner,
	input[2:0] score1,score2,
	input[2:0] ball,
	output reg[2:0] rgb_text,
	output[5:0] rgb_on
    );
	 reg minjaj1=0,minjaj2=0,minjaj3=0,minjaj4=0;
	 reg provjerazaalways = 0;
	 reg [1:0] smanji=0;
	 reg minjajsekunde=0;
	 reg[3:0] maxsekunde=10;
	 reg[3:0] brojpritisaka=0,brojpritisaka2=1,brojprit1=0,brojprit2=0,brojprit3=0,brojprit4=0;
	 reg botun_on,score1_on,score2_on,win_on,rule_on,crtaj;
	 reg[6:0] ascii_code,ascii_code_logo,ascii_code_score1,ascii_code_score2,ascii_code_win,ascii_code_rule,ascii_code_ball;
	 reg[3:0] row_addr,row_addr_logo,row_addr_score1,row_addr_score2,row_addr_win,row_addr_rule,row_addr_ball;
	 wire[7:0] row_data;
	 reg[2:0] bit_column,bit_column_logo,bit_column_score1,bit_column_score2,bit_column_win,bit_column_rule,bit_column_ball;
	 reg[4:0] col_temp;
	 
	 reg[26:0] timer=0,timer2=0; //OVO SMO DODALI 
	 reg[3:0] brojsekundi=0; //I OVO
	 reg[6:0] pomocnireg=0,pomocnireg2=0;  //OVO TAKODER
	 reg [1:0] trenbotun=0;
	 reg [1:0] zivoti, zivoti1=2, zivoti2=3, zivoti3=3, zivoti4=3,zbrojzivoti=0;							//zivoti
	 reg[3:0] score=0,scoreprvi=0,scoredrugi=0,scoretreci=0,scorecetvrti=0;
	 reg provjerazatrenbotun,provjerazatrenbotun2;
	 reg stanje1=0,stanje2=0,stanje3=0,stanje4=0;
	 reg kraj=0;
	 
		reg[23:0] counter;
		reg[1:0] state,nasumbroj=0;
	
	
	always @ (posedge key1) begin //mozda to traje dok god je botun pritisnut sta je previse jer ce prebrzo povecat core
		
		brojprit1=brojprit1+1;
		minjaj1=~minjaj1;
		#260000 minjaj1=~minjaj1;
		if(trenbotun==0) begin
			if(score!=9)
			scoreprvi=scoreprvi+1;
			end
			else
			zivoti1=zivoti1-1;
			stanje1=~stanje1;
	end
	
	always @ (posedge key2) begin //mozda to traje dok god je botun pritisnut sta je previse jer ce prebrzo povecat core
		brojprit2=brojprit2+1;
		minjaj2=~minjaj2;
		#260000 minjaj2=~minjaj2;
		if(trenbotun==1) begin
		if(score!=9)
			scoredrugi=scoredrugi+1;
			end
			else
			zivoti2=zivoti2-1;
			stanje2=~stanje2;
			
	end
	
	always @ (posedge key3) begin //mozda to traje dok god je botun pritisnut sta je previse jer ce prebrzo povecat core
		brojprit3=brojprit3+1;
		minjaj3=~minjaj3;
		#260000 minjaj3=~minjaj3;
		if(trenbotun==2) begin
		if(score!=9)
			scoretreci=scoretreci+1;
			end
			else
			zivoti3=zivoti3-1;
			stanje3=~stanje3;
	end
	
	always @ (posedge key4) begin //mozda to traje dok god je botun pritisnut sta je previse jer ce prebrzo povecat core
		brojprit4=brojprit4+1;
		minjaj4=~minjaj4;
		#260000 minjaj4=~minjaj4;
		if(trenbotun==3) begin
		if(score!=9)
			scorecetvrti=scorecetvrti+1;
			end
			else
			zivoti4=zivoti4-1;
			stanje4=~stanje4;
		//if(zivoti==0)
	end

	always @ * begin 
		minjajsekunde = minjaj1 || minjaj2 || minjaj3 || minjaj4;
	end
	
	always @ (posedge clk) begin 
	if(key1)brojsekundi=maxsekunde;
	else if(key2)brojsekundi=maxsekunde;
	else if(key3)brojsekundi=maxsekunde;
	else if(key4)brojsekundi=maxsekunde;
	if (brojsekundi == maxsekunde) begin 
		brojsekundi=brojpritisaka;
		smanji=smanji+1;
		end
	if(brojsekundi>10)
		brojsekundi=maxsekunde-1;
	timer=timer+1;
	if((timer%64)==0) timer2=timer2+1;
		 if(timer==26000000) begin
			brojsekundi=brojsekundi+1;
			timer=0;
			timer2=0;
			if(minjajsekunde)brojsekundi=maxsekunde;
			end
			score=scoreprvi+scoredrugi+scoretreci+scorecetvrti;
			zivoti=zivoti1+zivoti2+zivoti3+zivoti4-smanji;
		
			brojpritisaka=brojprit1+brojprit2+brojprit3+brojprit4;
			//if(score==0)
				//zivoti=3;
			provjerazatrenbotun=stanje1+stanje2+stanje3+stanje4; //da imamo na sta reagirat
			if(minjajsekunde)brojsekundi=maxsekunde;
			
	end
	always @ (posedge clk) begin
	#260000 provjerazatrenbotun2=stanje1+stanje2+stanje3+stanje4; //da ne bude odma
			if(provjerazatrenbotun2!=provjerazatrenbotun)
				trenbotun=timer2;
				end
			
	
	
	
	 //control logic for all text on the game
	 always @* begin
		
		 botun_on=0;
		 score1_on=0;
		 score2_on=0;
		 score2_on=0;
		 win_on=0;
		 rule_on=0;
		 crtaj=0;
		 col_temp=0;
		 row_addr_logo=0;
		 row_addr_score1=0;
		 row_addr_score2=0;
		 row_addr_win=0;
		 row_addr_rule=0;
		 row_addr_ball=0;
		 bit_column_logo=0;
		 bit_column_score1=0;
		 bit_column_score2=0;
		 bit_column_win=0;
		 bit_column_rule=0;
		 bit_column_ball=0;
		 ascii_code_logo=0;
		 ascii_code_score1=0;
		 ascii_code_score2=0;
		 ascii_code_win=0;
		 ascii_code_rule=0;
		 ascii_code_ball=0;
		 
		 
			
		 
			//text logika za botun (64x128 char size)
			botun_on= (pixel_x[9:6]>=3 && pixel_x[9:6]<=6 && pixel_y[8:7]==2);
			row_addr_logo=pixel_y[6:3];
			bit_column_logo=pixel_x[5:3];
			case(trenbotun)
			0:pomocnireg=7'h31;
			1:pomocnireg=7'h32;
			2:pomocnireg=7'h33;
			3:pomocnireg=7'h34;
			endcase
			case(score)
			0:pomocnireg2=7'h30;
			1:pomocnireg2=7'h31;
			2:pomocnireg2=7'h32;
			3:pomocnireg2=7'h33;
			4:pomocnireg2=7'h34;
			5:pomocnireg2=7'h35;
			6:pomocnireg2=7'h36;
			7:pomocnireg2=7'h37;
			8:pomocnireg2=7'h38;
			9:pomocnireg2=7'h39;
			endcase
			
			case(pixel_x[9:6])
				4'd4: ascii_code_logo=7'h42; //B
				4'd5: ascii_code_logo=pomocnireg;
				//ascii_code_logo=7'h31; //1
			endcase
			
			
			
			score1_on =(pixel_x[9:8]==0 && pixel_y[8:5]==0);
			row_addr_score1=pixel_y[4:1];
			bit_column_score1=pixel_x[3:1];
			case(pixel_x[7:4])
				4'h1: ascii_code_score1=8'h4c; //L
				4'h2: ascii_code_score1=8'h49; //I
				4'h3: ascii_code_score1=8'h56; //V
				4'h4: ascii_code_score1=8'h45; //E
				4'h5: ascii_code_score1=8'h53; //S
				4'h6: ascii_code_score1=8'h3a; //:
				//4'h7: ascii_code_score1=8'h33; //S 
				4'h7:begin if(zivoti==0)ascii_code_score1=8'h00; //prazno
								else ascii_code_score1=8'h03; //SRCE
						end
				4'h8: begin if(zivoti<2) ascii_code_score1=8'h00; //Prazno
								else ascii_code_score1=8'h03; //SRCE
						end
				4'h9: begin if(zivoti==3)ascii_code_score1=8'h03; //SRCE
								else ascii_code_score1=8'h00; //prazno
						end 
			endcase

			score2_on =( pixel_x[9:4]>=24 && pixel_x[9:4]<=39 && pixel_y[8:5]==0);
			row_addr_score2=pixel_y[4:1];
			bit_column_score2=pixel_x[3:1];
			case(pixel_x[9:4])
				6'd32: ascii_code_score2=8'h53; //S
				6'd33: ascii_code_score2=8'h43; //C
				6'd34: ascii_code_score2=8'h4f; //O
				6'd35: ascii_code_score2=8'h52; //R
				6'd36: ascii_code_score2=8'h45; //E
				6'd37: ascii_code_score2=8'h3a; //:
				6'd38: ascii_code_score2=pomocnireg2;
				6'd39: ascii_code_score2=0; //
			endcase	
			
				
			
			
			crtaj= (pixel_y[8:6]==2 && pixel_x[9:0]>=305 && pixel_x[9:0]<=336);
			row_addr_ball=pixel_y[5:2];
			col_temp=pixel_x[9:0]-304;
			bit_column_ball=col_temp[4:2];
			if(crtaj) begin
			case(brojsekundi)
			0:ascii_code_ball=8'h39;
			1:ascii_code_ball=8'h38;
			2:ascii_code_ball=8'h37;
			3:ascii_code_ball=8'h36;
			4:ascii_code_ball=8'h35;
			5:ascii_code_ball=8'h34;
			6:ascii_code_ball=8'h33;
			7:ascii_code_ball=8'h32;
			8:ascii_code_ball=8'h31;
			9:ascii_code_ball=8'h30;
			default:ascii_code_ball=8'h15;
			endcase
			end

			
		
	 end
	 
	 assign font_bit=row_data[~{bit_column-3'd1}];
	 assign rgb_on= {score1_on,score2_on,rule_on,win_on,botun_on,crtaj};
	 
	 //rgb multiplexing
	 always @* begin
		rgb_text=0;
		row_addr=0;
		bit_column=0;
		ascii_code=0;
		rgb_text=3'b010; //background za mala polja //010
		if(!video_on) rgb_text=0;
		else if(crtaj) begin
			rgb_text=font_bit? 3'b100:rgb_text; //runde text color
			row_addr=row_addr_ball;
			bit_column=bit_column_ball;
			ascii_code=ascii_code_ball;
		end
		else if(score1_on) begin
			rgb_text=font_bit? 3'b000:rgb_text; //player 1 score text color
			row_addr=row_addr_score1;
			bit_column=bit_column_score1;
			ascii_code=ascii_code_score1;
		end
		else if(score2_on) begin
			rgb_text=font_bit? 3'b000:rgb_text; //player 2 score text color
			row_addr=row_addr_score2;
			bit_column=bit_column_score2;
			ascii_code=ascii_code_score2;
		end
		
		else if(rule_on) begin
			rgb_text=font_bit? 3'b000:rgb_text; //rule text color //000
			row_addr=row_addr_rule;
			bit_column=bit_column_rule;
			ascii_code=ascii_code_rule;
		end
		else if(win_on) begin
			rgb_text=font_bit? 3'b000:rgb_text; //game winner text color
			row_addr=row_addr_win;
			bit_column=bit_column_win;
			ascii_code=ascii_code_win;
		end
		else if(botun_on) begin
			rgb_text=font_bit? 3'b111:rgb_text;
			row_addr=row_addr_logo;
			bit_column=bit_column_logo;
			ascii_code=ascii_code_logo;
		end
	end

	 
	 
	 
	 //module instantiations
    font_rom m0
   (
		.clk(clk),
		.addr({ascii_code,row_addr}), //[10:4] for ASCII char code, [3:0] for choosing what row to read on a given character  
		.data(row_data)
   );

endmodule