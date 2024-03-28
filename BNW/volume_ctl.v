`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/21 23:06:05
// Design Name: 
// Module Name: volume_ctl
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


module volume_ctl ( /*input*/clk, rst_n,
    /*button*/ up_shp, down_shp, up_db, down_db,
    /*output*/ high, low, lv_ten, lv_uni );

    input clk, rst_n;
    input up_shp, down_shp, up_db, down_db;

    output reg [15:0] high, low;
    output reg [3:0] lv_ten, lv_uni;

    reg [11:0] up_press_cnt, down_press_cnt;
    reg [11:0] next_up_press_cnt, next_down_press_cnt;

    wire up_fast, down_fast;
    assign up_fast = ( up_press_cnt > 100 ) && ( up_press_cnt % 20 == 2 );
    assign down_fast = ( down_press_cnt > 100 ) && ( down_press_cnt % 20 == 2 );

    wire add, sub;
    assign add = up_shp || up_fast;
    assign sub = down_shp || down_fast;

    reg [6:0] level, level_next;
    reg [15:0] high_next, low_next;

    //-------------------------up_fast-----down_fast----------------------------------------------------------
    //combinational logic
    always@*
    begin
        if( up_db )
            begin
                next_up_press_cnt = up_press_cnt + 1;
            end
        else
            begin
                next_up_press_cnt = 0;
            end
        if( down_db )
            begin
                next_down_press_cnt = down_press_cnt + 1;
            end
        else
            begin
                next_down_press_cnt = 0 ;
            end
    end

    //sequential logic
    always @( posedge clk or negedge rst_n )
    begin
        if ( ~rst_n )
            begin
                up_press_cnt = 0;
                down_press_cnt = 0;
            end
        else
            begin
                up_press_cnt = next_up_press_cnt;
                down_press_cnt = next_down_press_cnt;
            end
    end

    //-------------------------------------------------level counter---------------------------------------------
    //combinational logic
    always @*
    if ( ( add == 1'b1 ) && ( sub == 1'b0 ) && ( level != 7'd99 ) )
        begin
            high_next = high + 16'd330;
            low_next = low - 16'd330;
            level_next = level + 1'b1;
        end
    else if ( ( add == 1'b0 ) && ( sub == 1'b1 ) && ( level != 7'd0 ) )
        begin
            high_next = high - 16'd330;
            low_next = low + 16'd330;
            level_next = level - 1'b1;
        end
    else
        begin
            high_next = high;
            low_next = low;
            level_next = level;
        end

        //sequential logic
    always @( posedge clk or negedge rst_n )
    if ( ~rst_n )
        begin
            high = 16'h0000;
            low = 16'hFFFF;
            level = 4'd0;
        end
    else
        begin
            high = high_next;
            low = low_next;
            level = level_next;
        end
        //---------------------------convert binary into BCD-------------------------
    always@*
    begin
        if( level > 4'd9 )
            begin
                lv_ten = level / 10;
                lv_uni = level % 10;
            end
        else
            begin
                lv_ten = 4'b1111; //dark
                lv_uni = level;
            end
    end


endmodule
