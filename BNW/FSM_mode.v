`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/20 00:05:44
// Design Name: 
// Module Name: FSM_mode
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

module FSM_mode( /*input*/clk, rst_n, ln_press,
    /*output*/ state );


    input clk;
    input rst_n;
    input ln_press;

    output reg [1:0] state;

    reg [1:0] next_state;

    always@*
    begin
        case( state )

            `state_game:
            begin
                if( ln_press )
                    begin
                        next_state = `state_volume;
                    end
                else
                    begin
                        next_state = `state_game;
                    end
            end

            `state_volume:
            begin
                if( ln_press )
                    begin
                        next_state = `state_level;
                    end
                else
                    begin
                        next_state = `state_volume;
                    end
            end

            `state_level:
            begin
                if( ln_press )
                    begin
                        next_state = `state_game;
                    end
                else
                    begin
                        next_state = `state_level;
                    end
            end

            default:
            begin
                next_state = `state_game;
            end

        endcase
    end

    always@( posedge clk or negedge rst_n )
    begin
        if( ~rst_n )
            begin
                state = `state_game;
            end
        else
            begin
                state = next_state;
            end
    end
endmodule