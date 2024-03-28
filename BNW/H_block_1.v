`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/26 00:20:29
// Design Name: 
// Module Name: F_block_1
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


module H_block_1( /*input*/clk, rst_n, restart, stop_or_endgame, beat_cnt, /*output*/ block_h );

    input clk/*clk_beat_ten*/, rst_n;
    input restart, stop_or_endgame;
    input [6:0] beat_cnt;

    output reg [9:0] block_h;

    reg [9:0] next_block_h;

    //-----------------------beat_add----------------------------
    wire beat_add;
    reg [6:0] pre_beat_cnt;
    assign beat_add = ( beat_cnt > pre_beat_cnt );

    //sequential
    always@( posedge clk or negedge rst_n or posedge restart  )
    begin

        if( ~rst_n || restart )
            begin
                pre_beat_cnt = 0;
            end

        else
            begin
                pre_beat_cnt = beat_cnt;
            end

    end


    //--------------------------------new_block----------------------------------------------------
    reg new_block;
    //combinational
    always@*
    begin
        if ( beat_add )
            begin

                case( beat_cnt )
                    4, 22, 28, 34, 40, 46, 52, 58, 70, 76, 88:
                    begin
                        new_block = 1;
                    end

                    default
                    begin
                        new_block = 0;
                    end
                endcase
            end
        else
            begin
                new_block = 0;
            end
    end

    //----------------------------block_h-------------------------------------------
    //combinational
    always@*
    begin
        if( ( ~stop_or_endgame ) && ( block_h < 720 ) )
            begin
                next_block_h = block_h + 1;
            end
        else
            begin
                next_block_h = block_h;
            end
    end
    
    //sequential
    always@( posedge clk or negedge rst_n or posedge restart  )
    begin

        if( ~rst_n || restart )
            begin
                block_h = 720;
            end

        else if( new_block )
            begin
                block_h = 120;
            end

        else
            begin
                block_h = next_block_h;
            end

    end


endmodule
