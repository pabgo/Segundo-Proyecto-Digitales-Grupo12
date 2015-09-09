`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:14:45 08/25/2015 
// Design Name: 
// Module Name:    FFDSinc 
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
module FFDSinc(

input wire clk,reset,
input wire [7:0] datos,
input wire enable,
output wire [7:0] Q_out

 );
 
 reg [7:0] Q_actual,Q_next;
 
always@(posedge clk , posedge reset)

if(reset)
	begin
	Q_actual <=8'b0;

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
