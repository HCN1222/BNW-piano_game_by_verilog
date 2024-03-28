`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/30 01:42:59
// Design Name: 
// Module Name: star_cnt
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


module star_cnt( /*input*/clk, rst_n, restart, endgame, /*output*/ star_cnt );

    input clk, rst_n;
    input endgame;
    input restart;

    output reg [1:0] star_cnt;
    reg [1:0] next_star_cnt;

    //combinational logic
    always@*
    begin
        if( endgame && ( star_cnt < 3 ) )
            begin
                next_star_cnt = star_cnt + 1;
            end
        else
            begin
                next_star_cnt = star_cnt;
            end
    end

    //sequential logic
    always@( posedge clk or negedge rst_n or posedge restart )
    begin
        if( ~rst_n || restart )
            begin
                star_cnt = 0;
            end
        else
            begin
                star_cnt = next_star_cnt;
            end
    end

endmodule
