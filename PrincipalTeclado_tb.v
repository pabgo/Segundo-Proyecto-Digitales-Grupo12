`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:58:09 09/01/2015
// Design Name:   PrincipalTeclado
// Module Name:   C:/Users/Pablo/Documents/Academico/ITCR Electronica/VIII Semestre/Laboratorio de Digitales/Proyectos/ProyectoDigitales2/PrincipalTeclado_tb.v
// Project Name:  ProyectoDigitales2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: PrincipalTeclado
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module PrincipalTeclado_tb;

	// Inputs
	integer i,j;
	reg [10:0] aux;
	reg [10:0] data [0:32];
	reg clk;
	reg reset;
	reg ps2d;
	reg ps2c;
	reg rx_en;

	// Outputs
	wire Led1;
	wire Led2;
	wire Alarma2;
	wire [3:0] sel_display;
	wire [7:0] display;

	// Instantiate the Unit Under Test (UUT)
	PrincipalTeclado uut (
		.clk(clk), 
		.reset(reset), 
		.ps2d(ps2d), 
		.ps2c(ps2c), 
		.rx_en(rx_en), 
		.Led1(Led1), 
		.Led2(Led2), 
		.Alarma2(Alarma2), 
		.sel_display(sel_display), 
		.display(display)
	);

	initial begin
		// Initialize Inputs
		reset = 0;
		clk = 0;
		ps2d = 0;
		ps2c = 0;
		i = 0;
		j = 0;
		rx_en = 1;
		aux = 11'b00000000000;
		$readmemb("datos.txt",data);
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

		end
		
		initial begin
		reset = 1'b0;
		ps2d = 1;//@(negedge ps2c)
		for(i=0;i<34;i=i+1)
		begin
		aux = data[i];
		for(j=0;j<11;j=j+1)
		@(posedge ps2c) 
		ps2d = aux[j];
		end
		end

		
		initial begin
			ps2c = 0;
			forever #41667 ps2c = ~ps2c;
		end

		initial begin
			clk = 0;
			forever #5 clk = ~clk;
		end
	
      
endmodule

