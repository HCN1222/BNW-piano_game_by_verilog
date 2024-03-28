`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/18 15:36:48
// Design Name: 
// Module Name: push_button
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


module push_button( /*input*/clk_100, rst_n, pb_in, /*output*/ln_press, sh_press, db_in );

    input clk_100, rst_n;
    input pb_in;
    output ln_press, sh_press, db_in;

    //debounce
    wire db_in;
    debouncer DB ( /*input*/.clk( clk_100 ), .rst_n( rst_n ), .pb_in(pb_in ),
        /*output*/ .pb_debounced( db_in ) );

    //long and short press // level signal
    wire ln_lv, sh_lv;
    long_and_short_press up_LP_SP ( /*input*/.clk( clk_100 ), .rst_n( rst_n ), .in( db_in ),
        /*output*/ .long_press_lv( ln_lv ), .short_press_lv( sh_lv ) );

    one_pulse sh_OP ( /*input*/.clk( clk_100 ), .rst_n( rst_n ),
    /*output*/.in_trig( sh_lv ), .out_pulse( sh_press ) );
    
    one_pulse ln_OP ( /*input*/.clk( clk_100 ), .rst_n( rst_n ),
    /*output*/.in_trig( ln_lv ), .out_pulse( ln_press ) );

endmodule
