`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/30 01:52:21
// Design Name: 
// Module Name: show_vga
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


module show_vga( /*input*/ valid, stop, level, clk_blink, beat_cnt,  star_cnt, h_cnt, v_cnt,
    /*pixels*/ button_pixel, star_1_pixel, star_2_pixel, star_3_pixel, press_pixel,
    /*output*/ vgaRed, vgaGreen, vgaBlue );

    input valid;

    //star
    input stop;
    input [1:0] level;
    input clk_blink;
    input [6:0] beat_cnt;
    input [1:0] star_cnt;

    input [9:0] h_cnt, v_cnt;

    input [11:0] button_pixel, star_1_pixel, star_2_pixel, star_3_pixel, press_pixel;

    output reg [3:0] vgaRed, vgaGreen, vgaBlue;

    always@*
    begin
        if( valid )
            begin
                //press any button to start
                if( clk_blink && stop && ( h_cnt > 160 ) && ( v_cnt > 360 ) && ( h_cnt < 480 ) && ( v_cnt < 392 ) && ( press_pixel != 12'hfff ) )
                    begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'ha4f;
                    end
                    //first_star
                else if( ( level != 0 ) && ( star_cnt >= 1 ) && ( beat_cnt >= 32 ) && ( h_cnt > 200 ) && ( v_cnt > 90 ) && ( h_cnt < 280 ) && ( v_cnt < 170 ) && ( star_1_pixel != 12'hfff ) )
                    begin
                        {vgaRed, vgaGreen, vgaBlue} = star_1_pixel;
                    end
                    
                    //second star
                else if( ( level != 0 ) && ( star_cnt >= 2 ) && ( beat_cnt >= 64 ) && ( h_cnt > 280 ) && ( v_cnt > 50 ) && ( h_cnt < 360 ) && ( v_cnt < 130 ) && ( star_2_pixel != 12'hfff ) )
                    begin
                        {vgaRed, vgaGreen, vgaBlue} = star_2_pixel;
                    end
                    
                    //third star
                else if( ( level != 0 ) && ( star_cnt >= 3 ) && ( beat_cnt >= 95 ) && ( h_cnt > 360 ) && ( v_cnt > 90 ) && ( h_cnt < 440 ) && ( v_cnt < 170 ) && ( star_3_pixel != 12'hfff ) )
                    begin
                        {vgaRed, vgaGreen, vgaBlue} = star_3_pixel;
                    end

                    //show star while playing
                    //first_star
                else if( ( level != 0 ) && ( ( ( beat_cnt >= 32 ) && ( beat_cnt <= 34 ) ) || ( ( beat_cnt >= 64 ) && ( beat_cnt <= 66 ) ) || ( beat_cnt == 95 ) )
                 && ( h_cnt > 200 ) && ( v_cnt > 90 ) && ( h_cnt < 280 ) && ( v_cnt < 170 ) && ( star_1_pixel != 12'hfff ) )
                begin
                    {vgaRed, vgaGreen, vgaBlue} = star_1_pixel;
                end
                
                //second_star
                else if( ( level != 0 ) && ( ( ( beat_cnt >= 64 ) && ( beat_cnt <= 66 ) ) || ( beat_cnt == 95 ) )
                 && ( h_cnt > 280 ) && ( v_cnt > 50 ) && ( h_cnt < 360 ) && ( v_cnt < 130 ) && ( star_2_pixel != 12'hfff ) )
                begin
                    {vgaRed, vgaGreen, vgaBlue} = star_2_pixel;
                end
                
                //third star
                else if( ( level != 0 ) && ( beat_cnt == 95 ) 
                 && ( h_cnt > 360 ) && ( v_cnt > 90 ) && ( h_cnt < 440 ) && ( v_cnt < 170 ) && ( star_3_pixel != 12'hfff ) )
                begin
                    {vgaRed, vgaGreen, vgaBlue} = star_3_pixel;
                end
                
                else
                begin
                    {vgaRed, vgaGreen, vgaBlue} = button_pixel;
                end
            end
        else
            begin
                {vgaRed, vgaGreen, vgaBlue} = 12'h0;
            end

    end



endmodule
