`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/20 00:42:28
// Design Name: 
// Module Name: FSM_level_ctl
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

module FSM_level_ctl( /*input*/clk, rst_n, sh_press,
/*output*/ state );

    input clk;
    input rst_n;
    input sh_press;

    output reg [1:0] state;

    reg [1:0] next_state;

    always@*
    begin
        case( state )

            `state_level_1:
            begin
                if( sh_press )
                    begin
                        next_state = `state_level_2;
                    end
                else
                    begin
                        next_state = `state_level_1;
                    end
            end

            `state_level_2:
            begin
                if( sh_press )
                    begin
                        next_state = `state_level_3;
                    end
                else
                    begin
                        next_state = `state_level_2;
                    end
            end
            
           `state_level_3:
            begin
                if( sh_press )
                    begin
                        next_state = `state_endless;
                    end
                else
                    begin
                        next_state = `state_level_3;
                    end
            end
            
           `state_endless:
            begin
                if( sh_press )
                    begin
                        next_state = `state_level_1;
                    end
                else
                    begin
                        next_state = `state_endless;
                    end
            end

            default:
            begin
                next_state = `state_level_1;
            end

        endcase
    end

    always@( posedge clk or negedge rst_n )
    begin
        if( ~rst_n )
            begin
                state = `state_level_1;
            end
        else
            begin
                state = next_state;
            end
    end
    
endmodule
