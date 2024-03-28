`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/18 15:16:07
// Design Name: 
// Module Name: B_N_W
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

module B_N_W( /*system inputs*/ clk, rst_n,
    /*button*/ up_pb, mid_pb, down_pb,
    /*LEDs*/ light,
    /*seven_segment display*/ ssd_ctl, ssd_out,
    /*speaker*/ /*output*/ audio_mclk, audio_lrck, audio_sck, audio_sdin,
    /*keyboard*/ PS2_DATA, PS2_CLK,
    /*VGA*/ vgaRed, vgaGreen, vgaBlue, hsync, vsync,
    /************************hack******************************/hack
);

    //-----------------------processing input signals--------------------------------------------------------------------------------
    //system inputs
    input rst_n;
    input clk;
    input hack;

    wire rst_p;
    assign rst_p = ~rst_n;

    //generate clocks
    wire clk_1, clk_100, clk_1M, clk_25M;
    wire [1:0] clk_scan;

    clk_1_generator C1 ( .clk( clk ), .rst_n( rst_n ), .clk_out( clk_1 ) );
    clk_100_generator C100 ( .clk( clk ), .rst_n( rst_n ), .clk_out( clk_100 ) );
    clk_1M_generator C1M ( .clk( clk ), .rst_n( rst_n ), .clk_out( clk_1M ) );
    clk_25M_generator C25M ( .clk( clk ), .rst_n( rst_n ), .clk_out( clk_25M ) );
    clk_scan_generator CSCAN ( .clk( clk ), .rst_n( rst_n ), .clk_out( clk_scan ) );

    //keyboard
    inout wire PS2_DATA;
    inout wire PS2_CLK;

    wire [511:0] key_down;

    KeyboardDecoder KD (  /*inout*/ .PS2_DATA( PS2_DATA ), .PS2_CLK( PS2_CLK ), /*input*/.rst( rst_p ), .clk( clk ),
        /*output*/ .key_down( key_down ), .last_change(  ), .key_valid(  ) );

    //pressed FGHJ
    wire F_pressed, G_pressed, H_pressed, J_pressed;

    keyboard_FGHJ FGHJ (  /*input*/ .key_down( key_down ),
        /*output*/ .f_pressed( F_pressed ), .g_pressed( G_pressed ), .h_pressed( H_pressed ), .j_pressed( J_pressed ) );

    //button
    input up_pb, mid_pb, down_pb; //input push button signal
    wire up_db, down_db;
    wire up_lnp, mid_lnp, down_lnp; //output long press signal
    wire up_shp, mid_shp, down_shp; //output long press signal

    push_button PB_UP( /*input*/.clk_100( clk_100 ), .rst_n( rst_n ), .pb_in( up_pb ), /*output*/.ln_press( up_lnp ), .sh_press( up_shp ), .db_in( up_db ) );
    push_button PB_MID( /*input*/.clk_100( clk_100 ), .rst_n( rst_n ), .pb_in( mid_pb ), /*output*/.ln_press( mid_lnp ), .sh_press( mid_shp ), .db_in() );
    push_button PB_DOWN( /*input*/.clk_100( clk_100 ), .rst_n( rst_n ), .pb_in( down_pb ), /*output*/.ln_press( down_lnp ), .sh_press( down_shp ), .db_in( down_db ) );

    //------------------------------------------game--------------------------------------------------------------------------------------------------

    //mode  // game  / volume / level
    wire [1:0] mode;
    wire mode_lnp;
    wire stop_or_end;

    assign mode_lnp = mid_lnp && stop_or_end;

    FSM_mode MODE ( /*input*/.clk( clk_100 ), .rst_n( rst_n ), .ln_press( mode_lnp ), /*output*/ .state( mode )  );

    //start  // start / pause / restart
    wire stop_pb;
    wire stop;
    wire restart;
    wire FGHJ_down;

    assign stop_pb = mid_shp && ( mode == `state_game ) && ( ~endgame );
    assign restart = up_shp  && ( mode == `state_game );
    assign FGHJ_down = ( F_pressed || G_pressed || H_pressed || J_pressed ) && ( mode == `state_game );

    FSM_game_ctl FSM_GM ( /*input*/.clk( clk_100 ), .rst_n( rst_n ), .restart( restart ), .FGHJ_down( FGHJ_down ), .sh_press( stop_pb ), /*output*/ .state( stop ) );

    //level control
    wire [1:0] level;
    assign level_ctl_pb = mid_shp && ( mode == `state_level ) && ( stop_or_end ) && (( beat_cnt == 0 ) || ( beat_cnt == 96 ));

    FSM_level_ctl LV ( /*input*/.clk( clk_100 ), .rst_n( rst_n ), .sh_press( level_ctl_pb ), /*output*/ .state( level ) );



    //-----------------------------------------------------------speaker-------------------------------------------------------------------------------

    //beat generator //clk_beat = forth note
    wire clk_beat, clk_beat_ten;
    wire [6:0] beat_cnt;
    beat_generator BEAT ( /*input*/.clk( clk_1M ), .clk_1( clk_1 ), .rst_n( rst_n ), .restart( restart ), .stop( stop_or_end ), .level( level ),
        /*output*/ .clk_beat( clk_beat ), .clk_beat_ten( clk_beat_ten ) );
    beat_cnt B_CNT ( /*input*/ .clk_beat( clk_beat ), .stop( stop_or_end ), .restart( restart ), .rst_n( rst_n ),
        /*output*/ .beat_cnt( beat_cnt ) );

    //note generator 
    //remember to deal with the interval between notes ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! 
    wire [3:0] left_note, right_note;
    wire [21:0]  left_note_div, right_note_div;

    //BCD
    little_star STAR ( /*input*/ .beat_cnt( beat_cnt ), /*output*/ .left_note( left_note ), .right_note( right_note ) );
    note_div NOTE_DIV ( /*input*/ .left_note( left_note ), .right_note( right_note ), .stop( stop_or_end ), /*output*/ .left_note_div( left_note_div ), .right_note_div( right_note_div ) );

    output audio_mclk, audio_lrck, audio_sck, audio_sdin;
    wire [3:0] vol_ten, vol_uni;

    wire vol_up, vol_down;

    assign vol_up = up_shp && ( mode == `state_volume );
    assign vol_down = down_shp && ( mode == `state_volume );
    assign vol_up_db = up_db && ( mode == `state_volume );
    assign vol_down_db = down_db && ( mode == `state_volume );

    //speaker       //volume control 0~99 //         to be modified
    speaker SP ( /*input*/.clk( clk), .clk_100( clk_100 ), .rst_n( rst_n ), /*volume control*/.up_shp( vol_up ), .down_shp( vol_down ), .up_db( vol_up_db ), .down_db( vol_down_db ),
        /*note divider*/ .left_note_div( left_note_div ), .right_note_div( right_note_div ),
        /*output*/ .audio_mclk( audio_mclk ), .audio_lrck( audio_lrck ), .audio_sck( audio_sck ), .audio_sdin( audio_sdin ), .vol_ten( vol_ten ), .vol_uni( vol_uni ) );

    //---------------------------------------stopwatch-------------------------------------------------------------
    wire [3:0] min_ten, min_uni, sec_ten, sec_uni;
    wire [3:0] msec_ten, msec_uni;

    stopwatch_milli MSTW ( /*input*/.clk( clk_100 ), .stop( stop_or_end ), .level( level ), .rst_n( rst_n ), .restart( restart ),
        /*output*/ .sec_ten( sec_ten ), .sec_uni( sec_uni ), .msec_ten( msec_ten ), .msec_uni( msec_uni ) );

    //second  :  millisecond

    wire [3:0] stw_four, stw_three, stw_two, stw_one;

    //output the value showing in mode game
    stopwatch_show STW_SH ( /*input*/.level( level ),
        /*time*/ .sec_ten( sec_ten ), .sec_uni( sec_uni ), .msec_ten( msec_ten ), .msec_uni( msec_uni ),
        /*output*/ .four_bcd( stw_four ), .three_bcd( stw_three ), .two_bcd( stw_two ), .one_bcd( stw_one ) );

    //---------------------------------------seven-segment display----------------------------------------------------------
    output [3:0] ssd_ctl;
    output [7:0] ssd_out;

    wire [3:0] four_bcd, three_bcd, two_bcd, one_bcd;
    show_what SHWT ( /*input*/.mode( mode ),
        /*level*/ .level( level ),
        /*volume*/ .vol_ten( vol_ten ), .vol_uni( vol_uni ),
        /*stw*/ .stw_four( stw_four ), .stw_three( stw_three ), .stw_two( stw_two ), .stw_one( stw_one ),
        /*output*/ .four_bcd( four_bcd ), .three_bcd( three_bcd ), .two_bcd( two_bcd ), .one_bcd( one_bcd ) );

    show SH ( /*input*/.four_bcd( four_bcd ), .three_bcd( three_bcd ), .two_bcd( two_bcd ), .one_bcd( one_bcd ), .clk_scan( clk_scan ),
        /*output*/ .ctl( ssd_ctl ), .ssd_out( ssd_out ) );

    //------------------------------------------------falling blocks position-------------------------------------------------------------------------

    //ROW F
    wire [9:0] F_block_1_h, F_block_2_h, F_block_3_h, F_block_4_h, F_block_5_h, F_block_6_h;

    F_block_1 FB_1 ( /*input*/.clk( clk_beat_ten ), .rst_n( rst_n ), .restart( restart ), .stop_or_endgame( stop_or_end ), .beat_cnt( beat_cnt ),
        /*output*/ .block_h( F_block_1_h ) );
    F_block_2 FB_2 ( /*input*/.clk( clk_beat_ten ), .rst_n( rst_n ), .restart( restart ), .stop_or_endgame( stop_or_end ), .beat_cnt( beat_cnt ),
        /*output*/ .block_h( F_block_2_h ) );
    F_block_3 FB_3 ( /*input*/.clk( clk_beat_ten ), .rst_n( rst_n ), .restart( restart ), .stop_or_endgame( stop_or_end ), .level(level), .beat_cnt( beat_cnt ),
        /*output*/ .block_h( F_block_3_h ) );
    F_block_4 FB_4 ( /*input*/.clk( clk_beat_ten ), .rst_n( rst_n ), .restart( restart ), .stop_or_endgame( stop_or_end ), .beat_cnt( beat_cnt ),
        /*output*/ .block_h( F_block_4_h ) );
    F_block_5 FB_5 ( /*input*/.clk( clk_beat_ten ), .rst_n( rst_n ), .restart( restart ), .stop_or_endgame( stop_or_end ), .beat_cnt( beat_cnt ),
        /*output*/ .block_h( F_block_5_h ) );
    F_block_6 FB_6 ( /*input*/.clk( clk_beat_ten ), .rst_n( rst_n ), .restart( restart ), .stop_or_endgame( stop_or_end ), .beat_cnt( beat_cnt ),
        /*output*/ .block_h( F_block_6_h ) );

    //ROW G
    wire [9:0] G_block_1_h, G_block_2_h, G_block_3_h, G_block_4_h, G_block_5_h, G_block_6_h;

    G_block_1 GB_1 ( /*input*/.clk( clk_beat_ten ), .rst_n( rst_n ), .restart( restart ), .stop_or_endgame( stop_or_end ), .level(level), .beat_cnt( beat_cnt ),
        /*output*/ .block_h( G_block_1_h ) );
    G_block_2 GB_2 ( /*input*/.clk( clk_beat_ten ), .rst_n( rst_n ), .restart( restart ), .stop_or_endgame( stop_or_end ), .level(level), .beat_cnt( beat_cnt ),
        /*output*/ .block_h( G_block_2_h ) );
    G_block_3 GB_3 ( /*input*/.clk( clk_beat_ten ), .rst_n( rst_n ), .restart( restart ), .stop_or_endgame( stop_or_end ), .beat_cnt( beat_cnt ),
        /*output*/ .block_h( G_block_3_h ) );
    G_block_4 GB_4 ( /*input*/.clk( clk_beat_ten ), .rst_n( rst_n ), .restart( restart ), .stop_or_endgame( stop_or_end ), .beat_cnt( beat_cnt ),
        /*output*/ .block_h( G_block_4_h ) );
    G_block_5 GB_5 ( /*input*/.clk( clk_beat_ten ), .rst_n( rst_n ), .restart( restart ), .stop_or_endgame( stop_or_end ), .beat_cnt( beat_cnt ),
        /*output*/ .block_h( G_block_5_h ) );
    G_block_6 GB_6 ( /*input*/.clk( clk_beat_ten ), .rst_n( rst_n ), .restart( restart ), .stop_or_endgame( stop_or_end ), .beat_cnt( beat_cnt ),
        /*output*/ .block_h( G_block_6_h ) );

    //ROW H
    wire [9:0] H_block_1_h, H_block_2_h, H_block_3_h, H_block_4_h, H_block_5_h, H_block_6_h;

    H_block_1 HB_1 ( /*input*/.clk( clk_beat_ten ), .rst_n( rst_n ), .restart( restart ), .stop_or_endgame( stop_or_end ), .beat_cnt( beat_cnt ),
        /*output*/ .block_h( H_block_1_h ) );
    H_block_2 HB_2 ( /*input*/.clk( clk_beat_ten ), .rst_n( rst_n ), .restart( restart ), .stop_or_endgame( stop_or_end ), .beat_cnt( beat_cnt ),
        /*output*/ .block_h( H_block_2_h ) );
    H_block_3 HB_3 ( /*input*/.clk( clk_beat_ten ), .rst_n( rst_n ), .restart( restart ), .stop_or_endgame( stop_or_end ), .level(level), .beat_cnt( beat_cnt ),
        /*output*/ .block_h( H_block_3_h ) );
    H_block_4 HB_4 ( /*input*/.clk( clk_beat_ten ), .rst_n( rst_n ), .restart( restart ), .stop_or_endgame( stop_or_end ), .beat_cnt( beat_cnt ),
        /*output*/ .block_h( H_block_4_h ) );
    H_block_5 HB_5 ( /*input*/.clk( clk_beat_ten ), .rst_n( rst_n ), .restart( restart ), .stop_or_endgame( stop_or_end ), .beat_cnt( beat_cnt ),
        /*output*/ .block_h( H_block_5_h ) );
    H_block_6 HB_6 ( /*input*/.clk( clk_beat_ten ), .rst_n( rst_n ), .restart( restart ), .stop_or_endgame( stop_or_end ), .beat_cnt( beat_cnt ),
        /*output*/ .block_h( H_block_6_h ) );

    //ROW J
    wire [9:0] J_block_1_h, J_block_2_h, J_block_3_h, J_block_4_h, J_block_5_h, J_block_6_h;

    J_block_1 JB_1 ( /*input*/.clk( clk_beat_ten ), .rst_n( rst_n ), .restart( restart ), .stop_or_endgame( stop_or_end ), .level(level), .beat_cnt( beat_cnt ),
        /*output*/ .block_h( J_block_1_h ) );
    J_block_2 JB_2 ( /*input*/.clk( clk_beat_ten ), .rst_n( rst_n ), .restart( restart ), .stop_or_endgame( stop_or_end ), .level(level), .beat_cnt( beat_cnt ),
        /*output*/ .block_h( J_block_2_h ) );
    J_block_3 JB_3 ( /*input*/.clk( clk_beat_ten ), .rst_n( rst_n ), .restart( restart ), .stop_or_endgame( stop_or_end ), .beat_cnt( beat_cnt ),
        /*output*/ .block_h( J_block_3_h ) );
    J_block_4 JB_4 ( /*input*/.clk( clk_beat_ten ), .rst_n( rst_n ), .restart( restart ), .stop_or_endgame( stop_or_end ), .beat_cnt( beat_cnt ),
        /*output*/ .block_h( J_block_4_h ) );
    J_block_5 JB_5 ( /*input*/.clk( clk_beat_ten ), .rst_n( rst_n ), .restart( restart ), .stop_or_endgame( stop_or_end ), .beat_cnt( beat_cnt ),
        /*output*/ .block_h( J_block_5_h ) );
    J_block_6 JB_6 ( /*input*/.clk( clk_beat_ten ), .rst_n( rst_n ), .restart( restart ), .stop_or_endgame( stop_or_end ), .beat_cnt( beat_cnt ),
        /*output*/ .block_h( J_block_6_h ) );

    //-------------------------------------------WIN or LOSE-----------------------------------------------------------------------
    //prefix sum
    wire [5:0] F_check, G_check, H_check, J_check;

    F_check Fck ( /*input*/ .beat_cnt( beat_cnt ), /*output*/ .F_check( F_check ) );
    G_check Gck ( /*input*/ .beat_cnt( beat_cnt ), /*output*/ .G_check( G_check ) );
    H_check Hck ( /*input*/ .beat_cnt( beat_cnt ), /*output*/ .H_check( H_check ) );
    J_check Jck ( /*input*/ .beat_cnt( beat_cnt ), /*output*/ .J_check( J_check ) );


    //counter 
    wire wrong_F_bef_hacked, wrong_G_bef_hacked, wrong_H_bef_hacked, wrong_J_bef_hacked;
    wire wrong_F, wrong_G, wrong_H, wrong_J;
    wire win, lose;
    wire endgame;

    assign wrong_F = wrong_F_bef_hacked && (~hack);
    assign wrong_G = wrong_G_bef_hacked && (~hack);
    assign wrong_H = wrong_H_bef_hacked && (~hack);
    assign wrong_J = wrong_J_bef_hacked && (~hack);

    assign stop_or_end = stop || endgame;

    assign endgame = win || lose;

    assign win =  ( level != `state_endless ) && ( beat_cnt == 96 ) && ( ~lose );
    assign lose = wrong_F || wrong_G || wrong_H || wrong_J;

    keyboard_cnt Fcnt ( /*input*/.clk( clk_beat ), .rst_n( rst_n ), .restart( restart ), .stop_or_end( stop_or_end ), .beat_cnt( beat_cnt ), .check( F_check ), .press( F_pressed ),/*output*/.wrong( wrong_F_bef_hacked ) );
    keyboard_cnt Gcnt ( /*input*/.clk( clk_beat ), .rst_n( rst_n ), .restart( restart ), .stop_or_end( stop_or_end ), .beat_cnt( beat_cnt ), .check( G_check ), .press( G_pressed ),/*output*/.wrong( wrong_G_bef_hacked ) );
    keyboard_cnt Hcnt ( /*input*/.clk( clk_beat ), .rst_n( rst_n ), .restart( restart ), .stop_or_end( stop_or_end ), .beat_cnt( beat_cnt ), .check( H_check ), .press( H_pressed ),/*output*/.wrong( wrong_H_bef_hacked ) );
    keyboard_cnt Jcnt ( /*input*/.clk( clk_beat ), .rst_n( rst_n ), .restart( restart ), .stop_or_end( stop_or_end ), .beat_cnt( beat_cnt ), .check( J_check ), .press( J_pressed ),/*output*/.wrong( wrong_J_bef_hacked ) );

    //-------------------------------------------------VGA-----------------------------------------------------------------------------
    wire valid;
    wire [9:0] h_cnt, v_cnt;

    output [3:0] vgaRed, vgaGreen, vgaBlue;
    output hsync, vsync;

    vga_control   vga_ctl( /*input*/.pclk( clk_25M ), .reset( rst_p ),
        /*output*/ .hsync( hsync ), .vsync( vsync ), .valid( valid ), .h_cnt( h_cnt ), .v_cnt( v_cnt ) );

    wire [11:0] button_pixel;
    
    pixel_generator pixel_gen ( /*input*/.h_cnt( h_cnt ), .v_cnt( v_cnt ), .valid( valid ), .beat_cnt( beat_cnt ),
        .level( level ),
        /*wrong*/ .wrong_F( wrong_F ), .wrong_G( wrong_G ), .wrong_H( wrong_H ), .wrong_J( wrong_J ),
        /*ROW F*/ .F_block_1_h( F_block_1_h ), .F_block_2_h( F_block_2_h ), .F_block_3_h( F_block_3_h ), .F_block_4_h( F_block_4_h ), .F_block_5_h( F_block_5_h ), .F_block_6_h( F_block_6_h ),
        /*ROW G*/ .G_block_1_h( G_block_1_h ), .G_block_2_h( G_block_2_h ), .G_block_3_h( G_block_3_h ), .G_block_4_h( G_block_4_h ), .G_block_5_h( G_block_5_h ), .G_block_6_h( G_block_6_h ),
        /*ROW H*/ .H_block_1_h( H_block_1_h ), .H_block_2_h( H_block_2_h ), .H_block_3_h( H_block_3_h ), .H_block_4_h( H_block_4_h ), .H_block_5_h( H_block_5_h ), .H_block_6_h( H_block_6_h ),
        /*ROW J*/ .J_block_1_h( J_block_1_h ), .J_block_2_h( J_block_2_h ), .J_block_3_h( J_block_3_h ), .J_block_4_h( J_block_4_h ), .J_block_5_h( J_block_5_h ), .J_block_6_h( J_block_6_h ),
        /*star_blocks*/ .star_block_1_pixel( star_block_1_pixel ), .star_block_2_pixel( star_block_2_pixel ), .star_block_3_pixel( star_block_3_pixel ),
        /*output*/ .pixel( button_pixel ) );
        
        //stars and words
        
    wire [16:0] star_block_1_pixel_addr, star_block_2_pixel_addr, star_block_3_pixel_addr,  star_1_pixel_addr, star_2_pixel_addr, star_3_pixel_addr, press_pixel_addr;
    
    wire [9:0] star_block_1_v_pos, star_block_2_v_pos, star_block_3_v_pos;
    
    assign star_block_1_v_pos = ( H_block_1_h > 240 )?  H_block_1_h - 240  :  240 - H_block_1_h;
    assign star_block_2_v_pos = ( J_block_3_h > 240 )?  J_block_3_h - 240  :  240 - J_block_3_h;    
    assign star_block_3_v_pos = ( G_block_4_h > 240 )?  G_block_4_h - 240  :  240 - G_block_4_h;    
    
    //H1 row beat_cnt == 31
    mem_addr_gen star_block_1_addr ( /*input*/.h_cnt( h_cnt ), .v_cnt(v_cnt), .h_pos( 320 ), .v_pos( star_block_1_v_pos ), .width( 80 ), .max( 9600 ),/*output*/.pixel_addr( star_block_1_pixel_addr ) );
    //J3 row beat_cnt == 63
    mem_addr_gen star_block_2_addr ( /*input*/.h_cnt( h_cnt ), .v_cnt(v_cnt), .h_pos( 400 ), .v_pos( star_block_2_v_pos ), .width( 80 ), .max( 9600 ),/*output*/.pixel_addr( star_block_2_pixel_addr ) );
    //G4 row beat_cnt == 94
    mem_addr_gen star_block_3_addr ( /*input*/.h_cnt( h_cnt ), .v_cnt(v_cnt), .h_pos( 240 ), .v_pos( star_block_3_v_pos ), .width( 80 ), .max( 9600 ),/*output*/.pixel_addr( star_block_3_pixel_addr ) );

    mem_addr_gen star_1_addr ( /*input*/.h_cnt( h_cnt ), .v_cnt(v_cnt), .h_pos( 200 ), .v_pos( 90 ), .width( 80 ), .max( 6400 ),/*output*/.pixel_addr( star_1_pixel_addr ) );
    mem_addr_gen star_2_addr ( /*input*/.h_cnt( h_cnt ), .v_cnt(v_cnt), .h_pos( 280 ), .v_pos( 50 ), .width( 80 ), .max( 6400 ),/*output*/.pixel_addr( star_2_pixel_addr ) );
    mem_addr_gen star_3_addr ( /*input*/.h_cnt( h_cnt ), .v_cnt(v_cnt), .h_pos( 360 ), .v_pos( 90 ), .width( 80 ), .max( 6400 ),/*output*/.pixel_addr( star_3_pixel_addr ) );
    mem_addr_gen press_addr ( /*input*/.h_cnt( h_cnt ), .v_cnt(v_cnt), .h_pos( 160 ), .v_pos( 360 ), .width( 320 ), .max( 10240 ),/*output*/.pixel_addr( press_pixel_addr ) );

    wire [11:0] star_block_1_pixel, star_block_2_pixel, star_block_3_pixel, star_1_pixel, star_2_pixel, star_3_pixel, press_pixel;
    wire [11:0] data;
    
    blk_mem_gen_star_block_1 star_block_1_addr_mem_gen ( .clka( clk_25M ), .wea( 0 ), .addra( star_block_1_pixel_addr ), .dina( data[11:0] ), .douta( star_block_1_pixel ) );
    blk_mem_gen_star_block_2 star_block_2_addr_mem_gen ( .clka( clk_25M ), .wea( 0 ), .addra( star_block_2_pixel_addr ), .dina( data[11:0] ), .douta( star_block_2_pixel ) );
    blk_mem_gen_star_block_3 star_block_3_addr_mem_gen ( .clka( clk_25M ), .wea( 0 ), .addra( star_block_3_pixel_addr ), .dina( data[11:0] ), .douta( star_block_3_pixel ) );

    blk_mem_gen_star_1 star_1_addr_mem_gen ( .clka( clk_25M ), .wea( 0 ), .addra( star_1_pixel_addr ), .dina( data[11:0] ), .douta( star_1_pixel ) );
    blk_mem_gen_star_2 star_2_addr_mem_gen ( .clka( clk_25M ), .wea( 0 ), .addra( star_2_pixel_addr ), .dina( data[11:0] ), .douta( star_2_pixel ) );
    blk_mem_gen_star_3 star_3_addr_mem_gen ( .clka( clk_25M ), .wea( 0 ), .addra( star_3_pixel_addr ), .dina( data[11:0] ), .douta( star_3_pixel ) );
    blk_mem_gen_press press_addr_mem_gen ( .clka( clk_25M ), .wea( 0 ), .addra( press_pixel_addr ), .dina( data[11:0] ), .douta( press_pixel ) );
    
    wire [1:0] star_cnt;
    star_cnt star_cnt ( /*input*/.clk( clk_1 ), .rst_n( rst_n ), .restart( restart ), .endgame( endgame ), /*output*/.star_cnt( star_cnt ) );
    
    show_vga show_VGA ( /*input*/.valid( valid ), .stop( stop ), .level( level ), .clk_blink( clk_1 ), .star_cnt( star_cnt ), .beat_cnt( beat_cnt ), .h_cnt( h_cnt ), .v_cnt( v_cnt ),
     /*pixels*/.button_pixel( button_pixel ), .star_1_pixel( star_1_pixel ), .star_2_pixel( star_2_pixel ), .star_3_pixel( star_3_pixel ), .press_pixel( press_pixel ),
     /*output*/ .vgaRed( vgaRed ), .vgaGreen( vgaGreen ), .vgaBlue( vgaBlue ) );

    //-------------------------------------------lights----------------------------------------------------
    output [15:0] light;

    assign light [15] = ( mode ==`state_game );
    assign light [14] = ( mode ==`state_volume );
    assign light [13] = ( mode ==`state_level );
    assign light [12] = ~stop_or_end;
    assign light [11] = level [1];
    assign light [10] = level [0];
    assign light [9] = ( vol_ten >= 9 ) && ( vol_ten != 15 );
    assign light [8] = ( vol_ten >= 8 ) && ( vol_ten != 15 );
    assign light [7] = ( vol_ten >= 7 ) && ( vol_ten != 15 );
    assign light [6] = ( vol_ten >= 6 ) && ( vol_ten != 15 );
    assign light [5] = ( vol_ten >= 5 ) && ( vol_ten != 15 );
    assign light [4] = ( vol_ten >= 4 ) && ( vol_ten != 15 );
    assign light [3] = ( vol_ten >= 3 ) && ( vol_ten != 15 );
    assign light [2] = ( vol_ten >= 2 ) && ( vol_ten != 15 );
    assign light [1] = ( vol_ten >= 1 ) && ( vol_ten != 15 );
    assign light [0] = ( vol_ten != 4'd0 || vol_uni != 4'd0 );

endmodule