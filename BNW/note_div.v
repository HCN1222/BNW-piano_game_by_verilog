`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/20 17:34:04
// Design Name: 
// Module Name: note_div
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


module note_div( /*input*/left_note, right_note, stop, /*output*/ left_note_div, right_note_div );

    input [3:0] left_note, right_note;
    input stop;
    output reg [21:0]  left_note_div, right_note_div;

    //---------------right-------------------------
    always@*
    begin
        if( ~stop )
            case( right_note )
                1: right_note_div = 22'd95601; //mid do  //100M / 523 / 2 - 1
                2: right_note_div = 22'd85178; //mid re  //100M / 587 / 2 - 1
                3: right_note_div = 22'd75871; //mid do  //100M / 659 / 2 - 1
                4: right_note_div = 22'd71632; //mid do  //100M / 698 / 2 - 1
                5: right_note_div = 22'd63775; //mid do  //100M / 784 / 2 - 1
                6: right_note_div = 22'd56817; //mid do  //100M / 880 / 2 - 1
                7: right_note_div = 22'd50606; //mid do  //100M / 988 / 2 - 1

                default right_note_div = 22'd0;
            endcase
        else
            right_note_div = 22'd0;

    end
    //---------------left-------------------------
    always@*
    begin
        if( ~stop )
            case( left_note )
                1: left_note_div = 22'd190839; //low do  //100M / 262 / 2 - 1
                2: left_note_div = 22'd170067; //low re  //100M / 294 / 2 - 1
                3: left_note_div = 22'd151514; //low do  //100M / 330 / 2 - 1
                4: left_note_div = 22'd143265; //low do  //100M / 349 / 2 - 1
                5: left_note_div = 22'd127550; //low do  //100M / 392 / 2 - 1
                6: left_note_div = 22'd113635; //low do  //100M / 440 / 2 - 1
                7: left_note_div = 22'd101214; //low do  //100M / 494 / 2 - 1
                8: left_note_div = 22'd255101; //low do  //100M / 196 / 2 - 1
                9: left_note_div = 22'd202428; //low do  //100M / 247 / 2 - 1
                default left_note_div = 22'd0;
            endcase
        else
            left_note_div = 22'd0;
    end

endmodule
