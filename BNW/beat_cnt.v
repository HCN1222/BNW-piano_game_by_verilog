`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/20 17:09:23
// Design Name: 
// Module Name: beat_cnt
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


module beat_cnt( /*input*/ clk_beat, stop, restart, rst_n, /*output*/ beat_cnt );

    input clk_beat, stop, restart, rst_n;
    output reg [6:0] beat_cnt;

    reg [6:0] next_beat_cnt;

    //combinational logic
    always@*
    begin
        if( ~stop  )
            begin
                if( beat_cnt == 7'd96 )
                    begin
                        next_beat_cnt = 7'd0;
                    end
                else
                    begin
                        next_beat_cnt = beat_cnt + 112'b1;
                    end
            end
        else
            begin
                next_beat_cnt = beat_cnt;
            end
    end

    //sequential logic
    always@( posedge clk_beat or negedge rst_n or posedge restart )
    begin

        if( ~rst_n || restart )
            begin
                beat_cnt = 112'b0;
            end

        else
            begin
                beat_cnt = next_beat_cnt;
            end

    end


endmodule
