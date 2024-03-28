`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/23 21:50:18
// Design Name: 
// Module Name: speaker_control_I2S
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


module speaker_control_I2S(
    clk, rst_n,
    audio_left, audio_right,
    audio_mclk,  audio_lrck, audio_sck, audio_sdin );

    input clk, rst_n;
    input [15:0] audio_left, audio_right;

    output reg audio_mclk;
    output reg audio_lrck;
    output reg audio_sck;
    output audio_sdin;

    //divided clocks
    reg [8:0] cnt, cnt_next;
    //combinational circuits
    always@*
    begin
        cnt_next = cnt + 9'b1;
        audio_mclk = cnt [1];
        audio_lrck = cnt [8];
        audio_sck = cnt [3];
    end
    //sequential circuits
    always@( posedge clk or negedge rst_n )
    begin
        if( ~rst_n )
            begin
                cnt = 0;
            end
        else
            begin
                cnt = cnt_next;
            end
    end

parallel_to_serial P2S ( .rst_n( rst_n ), /*input*/ .parallel( { audio_left, audio_right } ), .clk_in( cnt [8] ), .clk_out( cnt [3] ), /*output*/ .serial( audio_sdin ) );

endmodule
