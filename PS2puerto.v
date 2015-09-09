`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:53:56 08/24/2015 
// Design Name: 
// Module Name:    PS2puerto 
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
module PS2puerto(
input wire clk, reset,  ///Clock de la Nexys y reset 

input wire ps2d, ps2c, rx_en,   ////ps2c es el clock del PS2, rx_en es usado para abilitar o no la operación de recepción de datos
//// psd2 

output reg rx_done_tick,  /// Esta variable funciona para decir que ya termino de recibir el dato

output wire [7:0] dout  ///8 datos a a utilizar
                        ///provenientes del teclado 
) ;

// symbolic state declaration
localparam [1:0]    ////
	idle = 2 'b00,      ////Estados de la maquina   
	dps = 2'b01,        //// 
	load = 2'b10;       ////

//signal delcaration

reg [1:0] state_reg, state_next;  /// Variables para cambiar cada estado de la maquina 


reg [7:0] filter_reg; ///En filter_reg y en filter_next
wire [7:0] filter_next;// se almacenan los 8 bits que se toman de muestra



reg f_ps2c_reg;   ///// Esta variable toma un valor de 1 o cero dependiendo del lugar que se encuentre del clock del ps2,
////De forma que cuando hallan solo unos en la variable filter_reg quiere decir que el punto o el lugar del clk de la ps2 esta en el 1 del clock
///Asi mismo cuando esta en la parte que solo hay ceros, el valor de la variable sera cero


wire f_ps2c_next;  


reg [3:0] n_reg, n_next;   ///lleva la cuenta de cuantos datos se han almacenado, deben ser nueve datos, por lo que por en cada ciclo n se le ira disminuyendo un 1



reg [10:0] b_reg,b_next;    //// Variables donde se almacenan los once datos que envia el teclado los cuales son el bit de paridad, los 8 bits de datos de cada ////////////////////////////tecla, el bit de inicio y el bit de parada    


wire fall_edge;   /// señal de flanco negativo 


////Detector de francos

always @(posedge clk, posedge reset)  //// ciclo que se lleva acabo cada vez que hay un siclo reloj de la nexys o un reset

if (reset)
	begin
		filter_reg<=0;        /////Cuando hay un reset todos los datos de la variable de que adquiere los datos del clock de del ps2 se envian a 0
		f_ps2c_reg <=0;       /////

	end
else 
	begin
		filter_reg<= filter_next;   ///Aqui se actualizan los valores del recolector de datos del clock de la ps2
		f_ps2c_reg<= f_ps2c_next;   ///

	end

assign filter_next = {ps2c,filter_reg[7:1]};      ///////Aqui es donde se iran metiendo los datos de la variable recolectora de valores, esto se realizara en ////////////////////////////////////////////////////////el bit mas significativo de forma que se hara un corrimeinto hacia la derecha  
assign f_ps2c_next = (filter_reg==8'b11111111) ? 1'b1:   ////////Aqui es donde se asignara el valor de 1 a 0 a la variable f_ps2c_next
					 (filter_reg==8'b00000000) ? 1'b0:   ////De forma que se pueda saber en que lugar esta la variable tomando los datos
					 f_ps2c_reg;    //////Aqui la variable tomara el valor anterior, esto pasa cuando la variable que recolecta los valores se encuentra en ///////////por ejemplo en 00001111 

 assign fall_edge = f_ps2c_reg & ~f_ps2c_next; ////Aqui es donde se activa la bandera que indica que hay un flanco negativo, esto se logra mediante un AND


                  ///////////////////////////////////////////////////////////// =>Aqui f_ps2c_next=1   
//                /                                      		       		  / 
//                /                 				             			  /  
//                /                					             			  / 
//                /                	 				  			 			  / 
//                /                					  			 			  /  
//////////////////                 					  			 			  //////////////////  =>Aquii f_ps2c_next=0  


         /////00001111\\\\\											 /////11110000\\\\\

//    \\\En este intervalo////										 \\\En este intervalo////
//    \\\El valor def_ps2c_next///                                     \\\El valor def_ps2c_next/// 
//    \\\es igual a            ///                                     \\\es igual a            ///
//    \\\f_ps2c_reg, es decir  ///									 \\\f_ps2c_reg, es decir  ///
//    \\\el valor anterior 0   ///									 \\\el valor anterior 1   ///	



/////////Parte secuencial de la maquina de estado (FSM) y datos de los registros


always @(posedge clk, posedge reset)    /////Aqui se inicializan los estados y se actualizan las variables
	if (reset)
		begin
		state_reg <= idle;
		n_reg <= 0;
		b_reg <= 0;
		end
	else
		begin
			state_reg <= state_next;
			n_reg <= n_next;
			b_reg <= b_next;

		end
				
/////Parte combinacional
always @*
begin 
	state_next = state_reg;    ///Se actualiza la variable de estado
	rx_done_tick = 1'b0;    ///Se inicializa la variable
	n_next = n_reg;    /// Se actualiza la variable que lleva la cuenta de las variables que son empaquetadas
	b_next = b_reg;    /// Aqui se almacenan los datos que son enviados del teclado


	case(state_reg)

		idle:
			if (fall_edge & rx_en)
				begin
				// shift in star bit

				b_next = {ps2d, b_reg[10:1]}; ///Se mete el bit de inicio en el paqute de datos

				n_next = 4'b1001;     /// Se pone la variable en nueve para luego ser decrementada para que se pueda llevar el control de los datos que son ///////////////////////// empaquetados 

				state_next = dps;  ///Se pasa al estado dps

				end

		dps:  //8 data + 1 parity + 1 stop


			if (fall_edge)

				begin
					b_next= {ps2d, b_reg[10:1]};   ///Se empaquete el bit de paridad y los 8 datos que se desean tomar del teclado y el bit de parada
					
					if (n_reg==0)
					
						state_next = load;

					else
						n_next = n_reg -1;

				end

		load: // extra clock to complete the last shift

			begin 
				state_next=idle;       
				rx_done_tick=1'b1;

			end
			// salidas
		endcase
	end
	assign dout = b_reg[8:1];  //// Aqui se asignan a la salida los 8 datos que se necesitan del teclado


endmodule

