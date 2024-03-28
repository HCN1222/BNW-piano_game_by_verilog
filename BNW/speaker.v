`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/20 21:50:44
// Design Name: 
// Module Name: speaker
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


module speaker( /*input*/clk, clk_100, rst_n,
    /*volume control*/ up_shp, down_shp, up_db, down_db,
    /*note div*/ left_note_div, right_note_div,
    /*output*/ /*sound*/ audio_mclk, audio_lrck, audio_sck, audio_sdin,
    /*volume*/ vol_ten, vol_uni );

    input clk, clk_100, rst_n;
    input up_shp, down_shp, up_db, down_db;
    input [21:0] left_note_div, right_note_div;

    output audio_mclk, audio_lrck, audio_sck, audio_sdin;
    output [3:0] vol_ten, vol_uni;

    //volume control
    wire [15:0] high, low;

    volume_ctl VCTL ( /*input*/.clk( clk_100 ), .rst_n( rst_n ), 
    /*button*/.up_shp( up_shp ), .down_shp( down_shp ), .up_db( up_db ), .down_db( down_db ),
    /*output*/ .high( high ), .low( low ), .lv_ten( vol_ten ), .lv_uni( vol_uni )  );

    //buzzer control
    wire [15:0] audio_left, audio_right;
    buzzer_ctl BCTL ( .clk( clk ), .rst_n( rst_n ), /*input*/.note_div_left( left_note_div ), .note_div_right( right_note_div ), .high( high ), .low( low ),
        /*output*/ .audio_left( audio_left ), .audio_right( audio_right ) );

    //speaker control
    speaker_control_I2S SCTL ( .clk( clk ), .rst_n( rst_n ), /*input*/ .audio_left( audio_left ), .audio_right( audio_right ), /*output*/ .audio_mclk( audio_mclk ),  .audio_lrck( audio_lrck ), .audio_sck( audio_sck ), .audio_sdin( audio_sdin ) );
endmodule

