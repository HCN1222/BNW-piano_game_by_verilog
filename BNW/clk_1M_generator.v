`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/28 21:05:30
// Design Name: 
// Module Name: clk_1M_generator
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


module clk_1M_generator( clk, rst_n, clk_out );

    input clk;
    input rst_n;
    output reg clk_out;

    reg [5:0] cnt;
    reg [5:0] cnt_next;
    reg clk_next;
    reg clk_out_next;

    always@*
    begin
        if(cnt < 16'd49)
            begin
                cnt_next = cnt + 1'b1;
                clk_out_next = clk_out;
            end
        else
            begin
                cnt_next = 1'b0;
                clk_out_next = (~clk_out);
            end
    end

    always@(posedge clk or negedge rst_n)
    begin
        if(~rst_n)
            begin
                cnt <= 6'b0;
                clk_out <= 1'b0;
            end
        else
            begin
                cnt <= cnt_next;
              clk_out <= clk_out_next;
            end
    end  
endmodule

