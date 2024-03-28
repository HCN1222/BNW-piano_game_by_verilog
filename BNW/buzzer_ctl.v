`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/21 23:38:11
// Design Name: 
// Module Name: buzzer_ctl
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


module buzzer_ctl ( clk, rst_n, /*input*/note_div_left, note_div_right, high, low,
    /*output*/ audio_left, audio_right );

    input clk, rst_n;
    input [21:0] note_div_left, note_div_right;
    input [15:0] high, low;

    output [15:0] audio_left, audio_right;

    reg [21:0] left_clk_cnt, left_clk_cnt_next;
    reg [21:0] right_clk_cnt, right_clk_cnt_next;
    reg left_clk, left_clk_next;
    reg right_clk, right_clk_next;

    //note frequency generation left
    always @*
    if ( ( note_div_left != 22'd0 ) && ( left_clk_cnt == note_div_left ) )
        begin
            left_clk_cnt_next = 22'd0;
            left_clk_next = ~left_clk;
        end
    else if ( ( note_div_left != 22'd0 ) && ( left_clk_cnt != note_div_left ) )
        begin
            left_clk_cnt_next = left_clk_cnt + 1'b1;
            left_clk_next = left_clk;
        end
    else
        begin
            left_clk_cnt_next = 22'd0;
            left_clk_next = 1'b0;
        end

        //note frequency generation right
    always @*
    if ( ( note_div_right != 22'd0 ) && ( right_clk_cnt == note_div_right ) )
        begin
            right_clk_cnt_next = 22'd0;
            right_clk_next = ~right_clk;
        end
    else if ( ( note_div_right != 22'd0 ) && ( right_clk_cnt != note_div_right ) )
        begin
            right_clk_cnt_next = right_clk_cnt + 1'b1;
            right_clk_next = right_clk;
        end
    else
        begin
            right_clk_cnt_next = 22'd0;
            right_clk_next = 1'b0;
        end

    always @( posedge clk or negedge rst_n )
    if ( ~rst_n )
        begin
            left_clk_cnt <= 22'd0;
            left_clk <= 1'b0;
            right_clk_cnt <= 22'd0;
            right_clk <= 1'b0;
        end
    else
        begin
            left_clk_cnt <= left_clk_cnt_next;
            left_clk <=left_clk_next;
            right_clk_cnt <= right_clk_cnt_next;
            right_clk <=right_clk_next;
        end

        //assign the amplitude of the note
    assign audio_left = ( left_clk == 1'b1 ) ? high : low;
    assign audio_right = ( right_clk == 1'b1 ) ? high : low;

endmodule