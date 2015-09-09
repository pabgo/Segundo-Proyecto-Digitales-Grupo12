`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:19:54 09/05/2015 
// Design Name: 
// Module Name:    FFDSinc1 
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
module FFDSinc1(


input wire clk,reset,
input wire datos,
input wire enable,
output wire Q_out

 );
 
 reg Q_actual,Q_next;
 
always@(posedge clk , posedge reset)

if(reset)
	begin
	Q_actual <=1'b0;

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


