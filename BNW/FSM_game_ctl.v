`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/20 00:26:31
// Design Name: 
// Module Name: FSM_game_ctl
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

module FSM_game_ctl ( /*input*/clk, rst_n, restart, FGHJ_down, sh_press,
/*output*/ state );


    input clk;
    input rst_n;
    input restart;
    input FGHJ_down;
    input sh_press;

    output reg state;

    reg next_state;

    always@*
    begin
        case( state )

            `state_stop:
            begin
                if( sh_press || FGHJ_down )
                    begin
                        next_state = `state_start;
                    end
                else
                    begin
                        next_state = `state_stop;
                    end
            end

            `state_start:
            begin
                if( sh_press )
                    begin
                        next_state = `state_stop;
                    end
                else
                    begin
                        next_state = `state_start;
                    end
            end

            default:
            begin
                next_state = `state_stop;
            end

        endcase
    end

    always@( posedge clk or negedge rst_n or posedge restart )
    begin
        if( ~rst_n || restart )
            begin
                state = `state_stop;
            end
        else
            begin
                state = next_state;
            end
    end
    
endmodule