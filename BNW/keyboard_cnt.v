`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/24 17:55:09
// Design Name: 
// Module Name: keyboard_cnt
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


module keyboard_cnt( /*input*/clk, rst_n, restart, stop_or_end, check, beat_cnt, press, /*output*/wrong );

    input clk, rst_n, restart;
    input [5:0] check;
    input [6:0] beat_cnt;
    input stop_or_end;
    input press;
    output wrong;

    reg [6:0] cnt, next_cnt;

    assign wrong = ( cnt != check );

    //combinational logic
    always@*
    begin

        if( stop_or_end )
            begin
                next_cnt = cnt;
            end

        else if( beat_cnt == 7'd96 )
            begin
                next_cnt = 7'b0;
            end

        else if( press )
            begin
                next_cnt = cnt + 1;
            end

        else
            begin
                next_cnt = cnt;
            end

    end

    //sequential logic
    always@( posedge clk or negedge rst_n or posedge restart )
    begin
        if( ~rst_n || restart )
            begin
                cnt = 7'b0;
            end
        else
            begin
                cnt = next_cnt;
            end
    end
endmodule
