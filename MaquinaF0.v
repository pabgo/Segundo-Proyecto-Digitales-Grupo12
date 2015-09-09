`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:54:23 08/24/2015 
// Design Name: 
// Module Name:    MaquinaF0 
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
module MaquinaF0
#(parameter N = 8)
	(
	input wire clk, reset, //	Clock y reset
	input wire [N-1:0] data_in,// Banderas de entrada
	output reg enableFF// Salidas, definidas como reg
);

//*********************************************************

localparam [1:0] // Codificacion de los estados o etiquetas 
	inicio = 2'b00,
	estado_1 = 2'b01,
	estado_2 = 2'b10,
	estado_3 = 2'b11;

reg [1:0] estado, estado_proximo; // Reg, estado actual y siguiente 


//*********************************************************
//Parte Secuencial

always@(posedge clk, posedge reset)
	if (reset)
		estado <= inicio;
	else
		estado <= estado_proximo;


//*********************************************************

//Parte Combinacional
always@*
begin
   		
	estado_proximo = estado;
	enableFF = 1'b0;
	
	
	case(estado)
		
		inicio:
			begin
			
			case (data_in)
				8'hF0:
					begin
					estado_proximo = estado_1;
					end
				
				default:
					begin
					estado_proximo = inicio;
					end
			endcase
			end
			
		estado_1:
			begin
			
			case (data_in)
				8'hF0:
					begin
					estado_proximo = estado_1;
					enableFF = 1'b0;
					end
				
				default:
					begin
					estado_proximo = estado_2;
					end
			endcase
			end	
			
		estado_2:
			begin
			enableFF = 1'b1;
			
			estado_proximo = inicio;
			end
			
		default:
			begin
			enableFF = 1'b0;
			estado_proximo = inicio;
			end
			
	endcase
end
endmodule

