`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:21:27 09/05/2015
// Design Name:   FFDSinc1
// Module Name:   C:/Users/Pablo/Documents/Academico/ITCR Electronica/VIII Semestre/Laboratorio de Digitales/Proyectos/ProyectoDigitales2/FFDSinc1_tb.v
// Project Name:  ProyectoDigitales2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: FFDSinc1
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module FFDSinc1_tb;

	// Inputs
	reg clk;
	reg reset;
	reg datos;
	reg enable;

	// Outputs
	wire Q_out;

	// Instantiate the Unit Under Test (UUT)
	FFDSinc1 uut (
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
		datos = 1'b0;
		enable = 0;
		
		#30
		reset= 1'b0;
		datos = 1'b1;
		enable = 0;
		
		#30
		reset= 1'b0;
		datos = 1'b0;
		enable = 0;
		
		#30
		reset= 1'b0;
		datos = 1'b1;
		enable = 1;
		
		#30
		reset= 1'b0;
		datos = 1'b0;
		enable = 0;
		
		#30
		reset= 1'b0;
		datos = 1'b1;
		enable = 0;
		
		#30
		reset= 1'b0;
		datos = 1'b0;
		enable = 1;
		
		#30
		reset= 1'b0;
		datos = 1'b1;
		enable = 0;
		
		#30
		reset= 1'b1;
		datos = 1'b0;
		enable = 0;
		
		#100
		$stop;

	end
      
endmodule
