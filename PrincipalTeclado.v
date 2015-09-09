`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:35:31 09/01/2015 
// Design Name: 
// Module Name:    PrincipalTeclado 
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
module PrincipalTeclado(
	input wire clk, reset,  ///Clock de la Nexys y reset 

	input wire ps2d, ps2c, rx_en,   ////ps2c es el clock del PS2, rx_en es usado para abilitar o no la operación de recepción de datos
//// psd2 
	output wire Led1,Led2, Alarma2,// Salidas
	output wire [3:0] sel_display,
	output wire [7:0] display
    );


wire rx_done_tick, humo;
wire [7:0] datos;
wire [2:0] corriente;

PS2puerto PuertoPS2 (
    .clk(clk), 
    .reset(reset), 
    .ps2d(ps2d), 
    .ps2c(ps2c), 
    .rx_en(rx_en), 
    .rx_done_tick(rx_done_tick), 
    .dout(datos)
    );
	 
RecepcionPS2 ProtocoloPS2 (
    .clk(clk), 
    .reset(reset), 
    .datos(datos), 
    .rx_done_tick(rx_done_tick), 
    .corriente(corriente), 
    .humo(humo)
    );
	 
Principal FSMPrimerProyecto (
    .clk(clk), 
    .reset(reset), 
    .humo(humo), 
    .current(corriente), 
    .Led1(Led1), 
    .Led2(Led2), 
    .Alarma2(Alarma2), 
    .sel_display(sel_display), 
    .display(display)
    );

	 
endmodule
