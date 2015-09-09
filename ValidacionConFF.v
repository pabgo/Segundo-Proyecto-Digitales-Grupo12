`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:36:18 09/05/2015 
// Design Name: 
// Module Name:    ValidacionConFF 
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
module ValidacionConFF
#(parameter N = 8, R = 3)
	(
	input wire clk, reset, //	Clock y reset
	input wire [N-1:0] data_in,// Banderas de entrada
	output wire [R-1:0] senal_corriente, 
	output wire senal_humo// Salidas, definidas como reg
    );
	 
wire ENFFcorriente, ENFFhuumo;
wire [2:0] VcorrienteFF;
wire VhumoFF;

ValidacionDato DatoValido (
    .clk(clk), 
    .reset(reset), 
    .data_in(data_in), 
    .enableFF_corriente(ENFFcorriente), 
    .enableFF_humo(ENFFhumo), 
    .senal_corriente(VcorrienteFF), 
    .senal_humo(VhumoFF)
    );

FFDSinc3 FFcorriente (
    .clk(clk), 
    .reset(reset), 
    .datos(VcorrienteFF), 
    .enable(ENFFcorriente), 
    .Q_out(senal_corriente)
    );
	 
FFDSinc1 FFhumo (
    .clk(clk), 
    .reset(reset), 
    .datos(VhumoFF), 
    .enable(ENFFhumo), 
    .Q_out(senal_humo)
    );

endmodule

