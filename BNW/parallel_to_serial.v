`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/23 22:08:37
// Design Name: 
// Module Name: parallel_to_serial
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


module parallel_to_serial(
    rst_n,
    parallel, clk_in, clk_out,
    serial );

    input rst_n;
    input [31:0] parallel;
    input clk_in;
    input clk_out;

    output reg serial;

    //input data buffer
    reg [31:0] para_buff;

    always@( negedge clk_in or negedge rst_n )
    begin
        if( ~rst_n )
            begin
                para_buff = 32'd0;
            end
        else
            begin
                para_buff = parallel;
            end
    end

    //counter
    reg [4:0] cnt, cnt_next;
    //combinational circuit
    always @*
    begin
        cnt_next = cnt + 1'b1;
    end
    //sequential circuit
    always @( negedge clk_out or negedge rst_n )
    if ( ~rst_n )
        cnt <= 5'd0;
    else
        cnt <= cnt_next;

        //parrallel to serial
    always @*
    case ( cnt )
        5'd0: serial = para_buff [0];
        5'd1: serial = para_buff [31];
        5'd2: serial = para_buff [30];
        5'd3: serial = para_buff [29];
        5'd4: serial = para_buff [28];
        5'd5: serial = para_buff [27];
        5'd6: serial = para_buff [26];
        5'd7: serial = para_buff [25];
        5'd8: serial = para_buff [24];
        5'd9: serial = para_buff [23];
        5'd10: serial = para_buff [22];
        5'd11: serial = para_buff [21];
        5'd12: serial = para_buff [20];
        5'd13: serial = para_buff [19];
        5'd14: serial = para_buff [18];
        5'd15: serial = para_buff [17];
        5'd16: serial = para_buff [16];
        5'd17: serial = para_buff [15];
        5'd18: serial = para_buff [14];
        5'd19: serial = para_buff [13];
        5'd20: serial = para_buff [12];
        5'd21: serial = para_buff [11];
        5'd22: serial = para_buff [10];
        5'd23: serial = para_buff [9];
        5'd24: serial = para_buff [8];
        5'd25: serial = para_buff [7];
        5'd26: serial = para_buff [6];
        5'd27: serial = para_buff [5];
        5'd28: serial = para_buff [4];
        5'd29: serial = para_buff [3];
        5'd30: serial = para_buff [2];
        5'd31: serial = para_buff [1];
        default: serial = 1'b0;
    endcase
endmodule
