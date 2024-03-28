`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/20 00:58:04
// Design Name: 
// Module Name: beat_generator
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
`include "global.v"

module beat_generator ( /*input*/ clk, clk_1, rst_n, restart, stop, level,
    /*output*/ clk_beat, clk_beat_ten );
    
    input clk, clk_1, rst_n;
    input restart, stop;
    input [1:0] level;
    output reg clk_beat_ten, clk_beat;

    //--------------------counter for endless mode--------------------
    reg [8:0] endless_cnt, next_endless_cnt;
    //combinational logic
    always@*
    begin
        if( ~stop )
            begin
                next_endless_cnt = endless_cnt * 15 / 14;
            end
        else
            begin
                next_endless_cnt = endless_cnt;
            end
    end

    //sequential circuit
    always@ ( posedge clk_1 or negedge rst_n or posedge restart )
    begin
        if( ~rst_n || restart )
            begin
                endless_cnt = 9'd60;
            end
        else
            begin
                endless_cnt = next_endless_cnt;
            end
    end

    //----------------------------allegro----------------------------------------
    reg [8:0] allegro;
    always@*
    begin
        case ( level )
            `state_endless: allegro = endless_cnt;
            `state_level_1:  allegro = 9'd60;//slow
            `state_level_2:  allegro = 9'd90;//sample
            `state_level_3:  allegro = 9'd120;//fast
            default
            allegro = 0; //should never happen
        endcase
    end
    
    //--------------------------genrate clk_beat_ten------------------------------------
    wire [12:0] beat_ten_div;
    assign beat_ten_div = 125000 / allegro -1; // ( 6000 / allegro ) * 1/2 * 1/2 - 1  //ten times clk_beat //use 10000Hz clock
    
    reg [12:0] beat_ten_cnt, next_beat_ten_cnt;
    reg next_clk_beat_ten;
    
    //combinational logoc
    always@*
    begin
        if( beat_ten_cnt < beat_ten_div )
            begin
                next_beat_ten_cnt = beat_ten_cnt + 1'b1;
                next_clk_beat_ten = clk_beat_ten;
            end
        else
            begin
                next_beat_ten_cnt = 1'b0;
                next_clk_beat_ten = ( ~clk_beat_ten );
            end
    end
    
//sequential logic
    always@( posedge clk or negedge rst_n or posedge restart )
    begin
        if( ~rst_n || restart )
            begin
                beat_ten_cnt <= 13'b0;
                clk_beat_ten <= 1'b0;
            end
        else
            begin
                beat_ten_cnt <= next_beat_ten_cnt;
                clk_beat_ten <= next_clk_beat_ten;
            end
    end
    
        //--------------------------genrate clk_beat------------------------------------
    reg next_clk_beat;
    reg [5:0] cnt, next_cnt;
    
    always@*
    begin
        if( cnt < 6'd59 )
            begin
                next_cnt = cnt + 6'd1;
                next_clk_beat = clk_beat;
            end
        else
            begin
                next_cnt = 6'd0;
                next_clk_beat = ~clk_beat;
            end
    end

    always@( posedge clk_beat_ten or negedge rst_n or posedge restart )
    begin
        if( ~rst_n || restart || stop )
            begin
                cnt = 0;
                clk_beat = 1;
            end
        else
            begin
                cnt = next_cnt;
                clk_beat = next_clk_beat;
            end
    end


endmodule