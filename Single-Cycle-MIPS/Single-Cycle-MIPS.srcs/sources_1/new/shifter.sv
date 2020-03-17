`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/17 18:39:23
// Design Name: 
// Module Name: shifter
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


module shifter #(DATALEN=32) (
    input logic [DATALEN-1:0] a,
    input logic [4:0] b,
    input logic [1:0] f,
    output logic [DATALEN-1:0] y
    );
    
    always_comb
        case (f)
            2'b00: y <= a;
            2'b01: y <= a << b;
            2'b10: y <= a >> b;
            2'b11: y <= a >>> b;
        endcase
    
    
endmodule
