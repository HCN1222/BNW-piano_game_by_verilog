`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/01 21:54:07
// Design Name: 
// Module Name: debouncer
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


module debouncer(clk, rst_n, pb_in, pb_debounced);

    input clk;
    input rst_n;
    input pb_in; //push_button_in
    output reg pb_debounced; //debounced push button output

    reg [3:0] debounce_window; //shift register flip flop
    reg pb_debounced_next; //debounce_result 

    //shift register
    always@(posedge clk or negedge rst_n)
    begin
        if(~rst_n)
            begin
                debounce_window <= 4'b0;
            end
        else
            begin
                debounce_window <= {debounce_window[2:0], pb_in};
            end
    end

    //debounce circuit
    always@*
    begin
        if(debounce_window == 4'b1111)
            begin
                pb_debounced_next = 1'b1;
            end
        else
            begin
                pb_debounced_next = 1'b0;
            end
    end

    always@(posedge clk or negedge rst_n)
    begin
        if(~rst_n)
            begin
                pb_debounced <= 1'b0;
            end
        else
            begin
                pb_debounced <= pb_debounced_next;
            end
    end

endmodule
