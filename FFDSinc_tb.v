`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:45:56 08/27/2015
// Design Name:   FFDSinc
// Module Name:   C:/Users/Pablo/Documents/Academico/ITCR Electronica/VIII Semestre/Laboratorio de Digitales/Proyectos/ProyectoDigitales2/FFDSinc_tb.v
// Project Name:  ProyectoDigitales2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: FFDSinc
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module FFDSinc_tb;

	// Inputs
	reg clk;
	reg reset;
	reg [7:0] datos;
	reg enable;

	// Outputs
	wire [7:0] Q_out;

	// Instantiate the Unit Under Test (UUT)
	FFDSinc uut (
		.clk(clk), 
		.reset(reset), 
		.datos(datos), 
		.enable(enable), 
		.Q_out(Q_out)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		datos = 0;
		enable = 0;

		// Wait 100 ns for global reset to finish
		#20
        
		// Add stimulus here
		forever #5 clk=~clk;
		end
		
		initial begin
		#30
		reset= 1'b1;
		datos = 8'hF7;
		enable = 0;
		
		#30
		reset= 1'b0;
		datos = 8'hF6;
		enable = 0;
		
		#30
		reset= 1'b0;
		datos = 8'h5a;
		enable = 0;
		
		#30
		reset= 1'b0;
		datos = 8'hF6;
		enable = 1;
		
		#30
		reset= 1'b0;
		datos = 8'h31;
		enable = 0;
		
		#30
		reset= 1'b0;
		datos = 8'hF0;
		enable = 0;
		
		#30
		reset= 1'b0;
		datos = 8'h5a;
		enable = 1;
		
		#30
		reset= 1'b0;
		datos = 8'h33;
		enable = 0;
		
		#30
		reset= 1'b1;
		datos = 8'hd3;
		enable = 0;
		
		#30
		reset= 1'b0;
		datos = 8'h8d;
		enable = 0;
		
		#30
		reset= 1'b0;
		datos = 8'h83;
		enable = 1;
		
		#30
		reset= 1'b0;
		datos = 8'h88;
		enable = 0;
		
		#30
		reset= 1'b0;
		datos = 8'h73;
		enable = 0;
		
		#30
		reset= 1'b0;
		datos = 8'h80;
		enable = 0;
		
		#100
		$stop;

	end
      
endmodule

