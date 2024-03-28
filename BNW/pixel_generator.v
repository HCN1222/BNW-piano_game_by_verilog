`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/26 17:40:56
// Design Name: 
// Module Name: pixel_generator
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


module pixel_generator(/*input*/ h_cnt, v_cnt, valid,
    beat_cnt, level,
    /*wrong*/ wrong_F, wrong_G, wrong_H, wrong_J,
    /*ROW F*/ F_block_1_h, F_block_2_h, F_block_3_h, F_block_4_h, F_block_5_h, F_block_6_h,
    /*ROW G*/ G_block_1_h, G_block_2_h, G_block_3_h, G_block_4_h, G_block_5_h, G_block_6_h,
    /*ROW H*/ H_block_1_h, H_block_2_h, H_block_3_h, H_block_4_h, H_block_5_h, H_block_6_h,
    /*ROW J*/ J_block_1_h, J_block_2_h, J_block_3_h, J_block_4_h, J_block_5_h, J_block_6_h,
    /*star blocks*/ star_block_1_pixel, star_block_2_pixel, star_block_3_pixel,
    /*output*/ pixel );

    input [9:0] h_cnt, v_cnt;
    input valid;
    input [1:0] level;
    input [6:0]beat_cnt;
    input wrong_F, wrong_G, wrong_H, wrong_J;
    input [9:0] /*ROW F*/F_block_1_h, F_block_2_h, F_block_3_h, F_block_4_h, F_block_5_h, F_block_6_h,
    /*ROW G*/ G_block_1_h, G_block_2_h, G_block_3_h, G_block_4_h, G_block_5_h, G_block_6_h,
    /*ROW H*/ H_block_1_h, H_block_2_h, H_block_3_h, H_block_4_h, H_block_5_h, H_block_6_h,
    /*ROW J*/ J_block_1_h, J_block_2_h, J_block_3_h, J_block_4_h, J_block_5_h, J_block_6_h;
    input [11:0] star_block_1_pixel, star_block_2_pixel, star_block_3_pixel;

    output reg [11:0] pixel;

    wire [9:0] trans_v_cnt;

    assign trans_v_cnt = v_cnt + 120;

    always@*
    begin
        if( ~valid )
            begin
                pixel = 12'b0000_0000_0000;
            end
        else if( ( 465 < trans_v_cnt ) && ( trans_v_cnt < 468 ) )
            begin
                pixel = 12'b0011_1101_1001;
            end

        else if( h_cnt <160 ) //margin
            begin
                pixel = 12'b1111_1101_1000;
            end
        else if( h_cnt < 240 ) // row F
            begin
                if( (
                /*block 1*/ ( ( F_block_1_h - 120 <= trans_v_cnt ) && ( trans_v_cnt <= F_block_1_h ) )
                /*block 2*/ || ( ( F_block_2_h - 120 <= trans_v_cnt ) && ( trans_v_cnt <= F_block_2_h ) )
                /*block 3*/ || ( ( F_block_3_h - 120 <= trans_v_cnt ) && ( trans_v_cnt <= F_block_3_h ) )
                /*block 4*/ || ( ( F_block_4_h - 120 <= trans_v_cnt ) && ( trans_v_cnt <= F_block_4_h ) )
                /*block 5*/ || ( ( F_block_5_h - 120 <= trans_v_cnt ) && ( trans_v_cnt <= F_block_5_h ) )
                /*block 6*/ || ( ( F_block_6_h - 120 <= trans_v_cnt ) && ( trans_v_cnt <= F_block_6_h ) )
                ) && ( trans_v_cnt > 467 ) )
                    begin
                        pixel = (wrong_F)? 12'b1111_0111_0111 : 12'b0100_1111_1111;
                    end
                else if( /*block 1*/( ( F_block_1_h -120 <= trans_v_cnt ) && ( trans_v_cnt <= F_block_1_h ) )
                /*block 2*/ || ( ( F_block_2_h - 120 <= trans_v_cnt ) && ( trans_v_cnt <= F_block_2_h ) )
                /*block 3*/ || ( ( F_block_3_h - 120 <= trans_v_cnt ) && ( trans_v_cnt <= F_block_3_h ) )
                /*block 4*/ || ( ( F_block_4_h - 120 <= trans_v_cnt ) && ( trans_v_cnt <= F_block_4_h ) )
                /*block 5*/ || ( ( F_block_5_h - 120 <= trans_v_cnt ) && ( trans_v_cnt <= F_block_5_h ) )
                /*block 6*/ || ( ( F_block_6_h - 120 <= trans_v_cnt ) && ( trans_v_cnt <= F_block_6_h ) )
                )
                    begin
                        pixel = 12'b0;
                    end
                else
                    begin
                        pixel = (wrong_F)? 12'b1111_0000_0000 : 12'b1111_1111_1111;
                    end
            end
        else if( h_cnt < 320 ) //row G
            begin

                if( (
                /*block 1*/ ( ( G_block_1_h - 120 <= trans_v_cnt ) && ( trans_v_cnt <= G_block_1_h ) )
                /*block 2*/ || ( ( G_block_2_h - 120 <= trans_v_cnt ) && ( trans_v_cnt <= G_block_2_h ) )
                /*block 3*/ || ( ( G_block_3_h - 120 <= trans_v_cnt ) && ( trans_v_cnt <= G_block_3_h ) )
                /*block 4*/ || ( ( G_block_4_h - 120 <= trans_v_cnt ) && ( trans_v_cnt <= G_block_4_h ) )
                /*block 5*/ || ( ( G_block_5_h - 120 <= trans_v_cnt ) && ( trans_v_cnt <= G_block_5_h ) )
                /*block 6*/ || ( ( G_block_6_h - 120 <= trans_v_cnt ) && ( trans_v_cnt <= G_block_6_h ) )
                ) && ( trans_v_cnt > 467 ) )
                    begin
                        pixel = (wrong_G)? 12'b1111_0111_0111 : 12'b0100_1111_1111;
                    end

                else if( ( G_block_4_h - 120 <= trans_v_cnt ) && ( trans_v_cnt <= G_block_4_h ) && (beat_cnt >= 91) && ( beat_cnt <= 95 )  && ( level != 0 ) )
                    begin
                        pixel = star_block_3_pixel;
                    end

                else if( /*block 1*/( ( G_block_1_h -120 <= trans_v_cnt ) && ( trans_v_cnt <= G_block_1_h ) )
                /*block 2*/ || ( ( G_block_2_h - 120 <= trans_v_cnt ) && ( trans_v_cnt <= G_block_2_h ) )
                /*block 3*/ || ( ( G_block_3_h - 120 <= trans_v_cnt ) && ( trans_v_cnt <= G_block_3_h ) )
                /*block 4*/ || ( ( G_block_4_h - 120 <= trans_v_cnt ) && ( trans_v_cnt <= G_block_4_h ) )
                /*block 5*/ || ( ( G_block_5_h - 120 <= trans_v_cnt ) && ( trans_v_cnt <= G_block_5_h ) )
                /*block 6*/ || ( ( G_block_6_h - 120 <= trans_v_cnt ) && ( trans_v_cnt <= G_block_6_h ) )
                )
                    begin
                        pixel = 12'b0;
                    end

                else
                    begin
                        pixel = (wrong_G)? 12'b1111_0000_0000 : 12'b1111_1111_1111;
                    end
            end
        else if( h_cnt < 400 ) //row H
            begin
                if( (
                /*block 1*/ ( ( H_block_1_h - 120 <= trans_v_cnt ) && ( trans_v_cnt <= H_block_1_h ) )
                /*block 2*/ || ( ( H_block_2_h - 120 <= trans_v_cnt ) && ( trans_v_cnt <= H_block_2_h ) )
                /*block 3*/ || ( ( H_block_3_h - 120 <= trans_v_cnt ) && ( trans_v_cnt <= H_block_3_h ) )
                /*block 4*/ || ( ( H_block_4_h - 120 <= trans_v_cnt ) && ( trans_v_cnt <= H_block_4_h ) )
                /*block 5*/ || ( ( H_block_5_h - 120 <= trans_v_cnt ) && ( trans_v_cnt <= H_block_5_h ) )
                /*block 6*/ || ( ( H_block_6_h - 120 <= trans_v_cnt ) && ( trans_v_cnt <= H_block_6_h ) )
                )&& ( trans_v_cnt > 467 ) )
                    begin
                        pixel = (wrong_H)? 12'b1111_0111_0111 : 12'b0100_1111_1111;
                    end

                else if( ( H_block_1_h - 120 <= trans_v_cnt ) && ( trans_v_cnt <= H_block_1_h ) && (beat_cnt >= 28) && ( beat_cnt <= 32 ) && ( level != 0 ) )
                    begin
                        pixel = star_block_1_pixel;
                    end

                else if( /*block 1*/( ( H_block_1_h - 120 <= trans_v_cnt ) && ( trans_v_cnt <= H_block_1_h ) )
                /*block 2*/ || ( ( H_block_2_h - 120 <= trans_v_cnt ) && ( trans_v_cnt <= H_block_2_h ) )
                /*block 3*/ || ( ( H_block_3_h - 120 <= trans_v_cnt ) && ( trans_v_cnt <= H_block_3_h ) )
                /*block 4*/ || ( ( H_block_4_h - 120 <= trans_v_cnt ) && ( trans_v_cnt <= H_block_4_h ) )
                /*block 5*/ || ( ( H_block_5_h - 120 <= trans_v_cnt ) && ( trans_v_cnt <= H_block_5_h ) )
                /*block 6*/ || ( ( H_block_6_h - 120 <= trans_v_cnt ) && ( trans_v_cnt <= H_block_6_h ) )
                )
                    begin
                        pixel = 12'b0000_0000_0000;
                    end

                else
                    begin
                        pixel = (wrong_H)? 12'b1111_0000_0000 : 12'b1111_1111_1111;
                    end
            end
        else if( h_cnt < 480 ) //row J
            begin
                if( (
                /*block 1*/ ( ( J_block_1_h - 120 <= trans_v_cnt ) && ( trans_v_cnt <= J_block_1_h ) )
                /*block 2*/ || ( ( J_block_2_h - 120 <= trans_v_cnt ) && ( trans_v_cnt <= J_block_2_h ) )
                /*block 3*/ || ( ( J_block_3_h - 120 <= trans_v_cnt ) && ( trans_v_cnt <= J_block_3_h ) )
                /*block 4*/ || ( ( J_block_4_h - 120 <= trans_v_cnt ) && ( trans_v_cnt <= J_block_4_h ) )
                /*block 5*/ || ( ( J_block_5_h - 120 <= trans_v_cnt ) && ( trans_v_cnt <= J_block_5_h ) )
                /*block 6*/ || ( ( J_block_6_h - 120 <= trans_v_cnt ) && ( trans_v_cnt <= J_block_6_h ) )
                ) && ( trans_v_cnt > 467 ) )
                    begin
                        pixel = (wrong_J)? 12'b1111_0111_0111 : 12'b0100_1111_1111;
                    end

                else if( ( J_block_3_h - 120 <= trans_v_cnt ) && ( trans_v_cnt <= J_block_3_h ) && (beat_cnt >= 60) && ( beat_cnt <= 64 ) && ( level != 0 ) )
                    begin
                        pixel = star_block_2_pixel;
                    end

                else if( /*block 1*/( ( J_block_1_h -120 <= trans_v_cnt ) && ( trans_v_cnt <= J_block_1_h ) )
                /*block 2*/ || ( ( J_block_2_h - 120 <= trans_v_cnt ) && ( trans_v_cnt <= J_block_2_h ) )
                /*block 3*/ || ( ( J_block_3_h - 120 <= trans_v_cnt ) && ( trans_v_cnt <= J_block_3_h ) )
                /*block 4*/ || ( ( J_block_4_h - 120 <= trans_v_cnt ) && ( trans_v_cnt <= J_block_4_h ) )
                /*block 5*/ || ( ( J_block_5_h - 120 <= trans_v_cnt ) && ( trans_v_cnt <= J_block_5_h ) )
                /*block 6*/ || ( ( J_block_6_h - 120 <= trans_v_cnt ) && ( trans_v_cnt <= J_block_6_h ) )
                )
                    begin
                        pixel = 12'b0000_0000_0000;
                    end
                else
                    begin
                        pixel = (wrong_J)? 12'b1111_0000_0000 : 12'b1111_1111_1111;
                    end
            end
        else //margin
            begin
                pixel = 12'b1111_1101_1000;
            end
    end
endmodule
