`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:00:02 09/01/2015
// Design Name:   ValidacionDato
// Module Name:   C:/Users/Pablo/Documents/Academico/ITCR Electronica/VIII Semestre/Laboratorio de Digitales/Proyectos/ProyectoDigitales2/ValidacionDato_tb.v
// Project Name:  ProyectoDigitales2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ValidacionDato
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ValidacionDato_tb;

	// Inputs
	reg clk;
	reg reset;
	reg [7:0] data_in;

	// Outputs
	wire [2:0] senal_corriente;
	wire senal_humo;

	// Instantiate the Unit Under Test (UUT)
	ValidacionDato uut (
		.clk(clk), 
		.reset(reset), 
		.data_in(data_in), 
		.senal_corriente(senal_corriente), 
		.senal_humo(senal_humo)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		data_in = 0;

		// Wait 100 ns for global reset to finish
				#20;
        
		// Add stimulus here
		forever #5 clk=~clk;
		end
		
		initial begin
		
		#17
		reset= 1'b0;
		data_in = 8'h00;
		
		#17
		reset= 1'b0;
		data_in = 8'h5a;
		
		#17
		reset= 1'b0;
		data_in = 8'h00;
		
		#17
		reset= 1'b0;
		data_in = 8'h2e;
		
		#17
		reset= 1'b0;
		data_in = 8'h00;
		
		#17
		reset= 1'b0;
		data_in = 8'h16;
		
		#17
		reset= 1'b0;
		data_in = 8'h00;
		
		#17
		reset= 1'b0;
		data_in = 8'h36;
		
		#17
		reset= 1'b0;
		data_in = 8'h00;
		
		#17
		reset= 1'b0;
		data_in = 8'h1e;
		
		#17
		reset= 1'b0;
		data_in = 8'h00;
		
		#17
		reset= 1'b0;
		data_in = 8'h3d;
		
		#17
		reset= 1'b0;
		data_in = 8'h00;
		
		#17
		reset= 1'b0;
		data_in = 8'h26;
		
		#17
		reset= 1'b0;
		data_in = 8'h00;
		
		#17
		reset= 1'b0;
		data_in = 8'h3e;
		
		#17
		reset= 1'b0;
		data_in = 8'h00;
		
		#17
		reset= 1'b0;
		data_in = 8'h25;
		
		#17
		reset= 1'b0;
		data_in = 8'h00;
		
		#17
		reset= 1'b0;
		data_in = 8'h31;
		
		#17
		reset= 1'b0;
		data_in = 8'h33;
		
		#17
		reset= 1'b0;
		data_in = 8'h00;
		
		#17
		reset= 1'b0;
		data_in = 8'h31;
				
		#17
		reset= 1'b0;
		data_in = 8'h00;
		
		#17
		reset= 1'b0;
		data_in = 8'h24;
		
		#17
		reset= 1'b0;
		data_in = 8'h36;
		
		#17
		reset= 1'b0;
		data_in = 8'h5a;
		
		#17
		reset= 1'b0;
		data_in = 8'h33;
		
		#17
		reset= 1'b1;
		data_in = 8'h26;
		
		#17
		reset= 1'b0;
		data_in = 8'h5a;
		
		#17
		reset= 1'b0;
		data_in = 8'h33;
		
		#50
		$stop;
		
	end
	
endmodule