`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:24:12 09/05/2015 
// Design Name: 
// Module Name:    FFDSinc3 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module FFDSinc3(input wire clk,reset,
input wire [2:0] datos,
input wire enable,
output wire [2:0] Q_out

 );
 
 reg [2:0] Q_actual,Q_next;
 
always@(posedge clk , posedge reset)

if(reset)
	begin
	Q_actual <=3'b0;

	end

else

	begin

	Q_actual<= Q_next;
	
	end

always @*

	if(enable)

		Q_next=datos;

	else

		Q_next = Q_actual;


assign Q_out = Q_next;

endmodule


