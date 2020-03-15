`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/09 08:42:59
// Design Name: 
// Module Name: mux2
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mux2 #(parameter DATALEN=32) (
    input logic [DATALEN-1:0] d0, d1,
    input logic s,
    output logic [DATALEN-1:0] y
    );
    
    assign y = s ? d1 : d0;
    
endmodule
