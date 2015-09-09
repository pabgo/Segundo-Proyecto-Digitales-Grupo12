`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:52:47 08/25/2015 
// Design Name: 
// Module Name:    ValidacionDato 
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
module ValidacionDato
#(parameter N = 8, R = 3)
	(
	input wire clk, reset, //	Clock y reset
	input wire [N-1:0] data_in,// Banderas de entrada
//	output reg [1:0] estado_actual,
	output reg enableFF_corriente, enableFF_humo,
	output reg [R-1:0] senal_corriente, 
	output reg senal_humo// Salidas, definidas como reg
);

//*********************************************************

localparam [1:0] // Codificacion de los estados o etiquetas 
	inicio = 2'b00,
	estado_1 = 2'b01,
	estado_2 = 2'b10,
	estado_3 = 2'b11;

reg [1:0] estado, estado_proximo; // Reg, estado actual y siguiente 
//reg [2:0] aux_corriente = 3'b000;
//reg aux_humo = 1'b0;




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
//	estado_actual = 2'b00;
	senal_corriente = 3'b000;
	senal_humo = 1'b0;
	enableFF_corriente = 1'b0;
	enableFF_humo = 1'b0;

	//se quita la inicializacion de variables pues otorga un error
	
	case(estado)
		
		inicio: // decide actuar si el dato es enter
			begin
//			estado_actual = 2'b00;
			case (data_in)
				
				8'h5a:
					begin
					estado_proximo = estado_1;
					end
				
				default:
					begin
					estado_proximo = inicio;
					end
			endcase
			end
			
		estado_1: // decide si el dato luego de enter es valido para realizar alguna accion en el circuito
			begin
//			estado_actual = 2'b01;
			case (data_in)
			
					
				8'h16:// tecla 1
					begin
					estado_proximo = estado_1;
					senal_corriente  = 3'b000;
					enableFF_corriente = 1'b1;
					end
					
				8'h1e:// tecla 2
					begin
					estado_proximo = estado_1;
					senal_corriente  = 3'b001;
					enableFF_corriente = 1'b1;
					end
					
				8'h26:// tecla 3
					begin
					estado_proximo = estado_1;
					senal_corriente  = 3'b010;
					enableFF_corriente = 1'b1;
					end
					
				8'h25:// tecla 4
					begin
					estado_proximo = estado_1;
					senal_corriente  = 3'b011;
					enableFF_corriente = 1'b1;
					end
					
				8'h2e:// tecla 5
					begin
					estado_proximo = estado_1;
					senal_corriente  = 3'b100;
					enableFF_corriente = 1'b1;
					end
					
				8'h36:// tecla 6
					begin
					estado_proximo = estado_1;
					senal_corriente  = 3'b101;
					enableFF_corriente = 1'b1;
					end
					
				8'h3d:// tecla 7
					begin
					estado_proximo = estado_1;
					senal_corriente  = 3'b110;
					enableFF_corriente = 1'b1;
					end
					
				8'h3e:// tecla 8
					begin
					estado_proximo = estado_1;
					senal_corriente  = 3'b111;
					enableFF_corriente = 1'b1;
					end
					
				8'h33://tecla h
					begin
					estado_proximo = estado_1;
					senal_humo = 1'b1;
					enableFF_humo = 1'b1;
					end
					
				8'h31: //tecla n
					begin
					estado_proximo = estado_1;
					senal_humo = 1'b0;
					enableFF_humo = 1'b1;
					end
					
				8'h24: //tecla e
					begin
					estado_proximo = inicio;
					end
				
				default:
					begin
					estado_proximo = estado_1;
					end
			endcase
			end	
			
		
		default:
			begin
			estado_proximo = inicio;
			senal_corriente = 3'b000;
			senal_humo = 1'b0;
			end
			
	endcase
end
endmodule

