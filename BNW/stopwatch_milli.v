`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/22 00:08:06
// Design Name: 
// Module Name: stopwatch_milli
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


module stopwatch_milli ( /*input*/clk, stop, level, rst_n, restart,
    /*output*/ sec_ten, sec_uni, msec_ten, msec_uni );

    input clk, rst_n, restart;
    input stop;
    input [1:0] level;
    output reg [3:0] sec_ten, sec_uni, msec_ten, msec_uni;

    reg [3:0] next_sec_ten, next_sec_uni, next_msec_ten, next_msec_uni;

    wire go;
    
    assign go = ~stop && level == `state_endless;

    //combinational logic
    //msec uni
    always@*
    begin
        if( go )
            begin
                if( msec_uni == 4'd9 )
                    begin
                        next_msec_uni = 4'b0;
                    end
                else
                    begin
                        next_msec_uni = msec_uni + 1;
                    end
            end
        else
            begin
                next_msec_uni = msec_uni;
            end
    end
    
    //msec ten
    always@*
    begin
        if( go )
            begin
                if( ( msec_ten == 4'd9 ) && ( msec_uni == 4'd9 ) )
                    begin
                        next_msec_ten = 4'b0;
                    end
                else if( ( msec_ten != 4'd9 ) && ( msec_uni == 4'd9 ) )
                    begin
                        next_msec_ten = msec_ten + 1;
                    end
                else
                    begin
                        next_msec_ten = msec_ten;
                    end
            end
        else
            begin
                next_msec_ten = msec_ten;
            end
    end

    //sec uni
    always@*
    begin
        if( go )
            begin
                if( ( sec_uni == 4'd9 ) && ( msec_ten == 4'd9 ) && ( msec_uni == 4'd9 ) )
                    begin
                        next_sec_uni = 0;
                    end
                else if( ( sec_uni != 4'd9 ) && ( msec_ten == 4'd9 ) && ( msec_uni == 4'd9 ) )
                    begin
                        next_sec_uni = sec_uni + 1;
                    end
                else
                    begin
                        next_sec_uni = sec_uni;
                    end
            end
        else
            begin
                next_sec_uni = sec_uni;
            end
    end
    
    //sec ten
    always@*
    begin
        if( go )
            begin
                if( ( sec_ten == 4'd9 ) && ( sec_uni == 4'd9 ) && ( msec_ten == 4'd9 ) && ( msec_uni == 4'd9 ) )
                    begin
                        next_sec_ten = 0;
                    end
                else if( ( sec_ten != 4'd9 ) && ( sec_uni == 4'd9 ) && ( msec_ten == 4'd9 ) && ( msec_uni == 4'd9 ) )
                    begin
                        next_sec_ten = sec_ten + 1;
                    end
                else
                    begin
                        next_sec_ten = sec_ten;
                    end
            end
        else
            begin
                next_sec_ten = sec_ten;
            end
    end
    
    //sequential logic
    always@( posedge clk or negedge rst_n or posedge restart )
    if( ~rst_n || restart )
        begin
            sec_ten = 4'b0;
            sec_uni = 4'b0;
            msec_ten = 4'b0;
            msec_uni = 4'b0;
        end
    else
        begin
            sec_ten = next_sec_ten;
            sec_uni = next_sec_uni;
            msec_ten = next_msec_ten;
            msec_uni = next_msec_uni;
        end
endmodule