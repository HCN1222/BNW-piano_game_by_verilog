`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/01 22:04:20
// Design Name: 
// Module Name: scan
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


module scan(four, three, two, one, clk_scan, ctl, ssd_out);

    input [7:0] four, three, two, one;

    input [1:0] clk_scan;
    output reg [3:0] ctl;
    output reg [7:0] ssd_out;

    always @*
    begin
        case(clk_scan)

            2'b00:
            begin
                ctl = 4'b0111;
                ssd_out = four;
            end

            2'b01:
            begin
                ctl = 4'b1011;
                ssd_out = three;
            end

            2'b10:
            begin
                ctl = 4'b1101;
                ssd_out = two;
            end

            2'b11:
            begin
                ctl = 4'b1110;
                ssd_out = one;
            end
        endcase
    end
endmodule
