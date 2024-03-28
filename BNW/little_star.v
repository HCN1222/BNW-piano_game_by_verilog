`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/20 18:21:58
// Design Name: 
// Module Name: little_star
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

module little_star ( /*input*/ beat_cnt,  /*output*/ left_note, right_note );

    input [6:0] beat_cnt;
    output reg [3:0] left_note, right_note;

    //-----------------------------right-------------------------------
    always@*
    begin
        case( beat_cnt )
            1: right_note = 4'd1;
            2: right_note = 4'd1;
            3: right_note = 4'd1;
            4: right_note = 4'd1;

            5: right_note = 4'd5;
            6: right_note = 4'd5;
            7: right_note = 4'd5;
            8: right_note = 4'd5;

            9: right_note = 4'd6;
            10: right_note = 4'd6;
            11: right_note = 4'd6;
            12: right_note = 4'd6;

            13: right_note = 4'd5;
            14: right_note = 4'd5;
            15: right_note = 4'd5;
            16: right_note = 4'd5;

            17: right_note = 4'd4;
            18: right_note = 4'd4;
            19: right_note = 4'd4;
            20: right_note = 4'd4;

            21: right_note = 4'd3;
            22: right_note = 4'd3;
            23: right_note = 4'd3;
            24: right_note = 4'd3;

            25: right_note = 4'd2;
            26: right_note = 4'd2;
            27: right_note = 4'd2;
            28: right_note = 4'd2;

            29: right_note = 4'd1;
            30: right_note = 4'd1;
            31: right_note = 4'd1;
            32: right_note = 4'd1;

            33: right_note = 4'd5;
            34: right_note = 4'd5;
            35: right_note = 4'd5;
            36: right_note = 4'd5;

            37: right_note = 4'd4;
            38: right_note = 4'd4;
            39: right_note = 4'd4;
            40: right_note = 4'd4;

            41: right_note = 4'd3;
            42: right_note = 4'd3;
            43: right_note = 4'd3;
            44: right_note = 4'd3;

            45: right_note = 4'd2;
            46: right_note = 4'd2;
            47: right_note = 4'd2;
            48: right_note = 4'd2;

            49: right_note = 4'd5;
            50: right_note = 4'd5;
            51: right_note = 4'd5;
            52: right_note = 4'd5;

            53: right_note = 4'd4;
            54: right_note = 4'd4;
            55: right_note = 4'd4;
            56 : right_note = 4'd4;

            57: right_note = 4'd3;
            58: right_note = 4'd3;
            59: right_note = 4'd3;
            60: right_note = 4'd3;

            61: right_note = 4'd2;
            62: right_note = 4'd2;
            63: right_note = 4'd2;
            64: right_note = 4'd2;

            65: right_note = 4'd1;
            66: right_note = 4'd1;
            67: right_note = 4'd1;
            68: right_note = 4'd1;

            69: right_note = 4'd5;
            70: right_note = 4'd5;
            71: right_note = 4'd5;
            72: right_note = 4'd5;

            73: right_note = 4'd6;
            74: right_note = 4'd6;
            75: right_note = 4'd6;
            76: right_note = 4'd6;

            77: right_note = 4'd5;
            78: right_note = 4'd5;
            79: right_note = 4'd5;
            80: right_note = 4'd5;

            81: right_note = 4'd4;
            82: right_note = 4'd4;
            83: right_note = 4'd4;
            84: right_note = 4'd4;

            85: right_note = 4'd3;
            86: right_note = 4'd3;
            87: right_note = 4'd3;
            88: right_note = 4'd3;

            89: right_note = 4'd2;
            90: right_note = 4'd2;
            91: right_note = 4'd2;
            92: right_note = 4'd2;

            93: right_note = 4'd1;
            94: right_note = 4'd1;
            95: right_note = 4'd1;
            96: right_note = 4'd1;


            default right_note = 4'd0;
        endcase
    end
    //-----------------------------left-------------------------------
    always@*
    begin
        case( beat_cnt )
            1: left_note = 4'd1;
            2: left_note = 4'd5;
            3: left_note = 4'd3;
            4: left_note = 4'd5;

            5: left_note = 4'd1;
            6: left_note = 4'd5;
            7: left_note = 4'd3;
            8: left_note = 4'd5;

            9: left_note = 4'd1;
            10: left_note = 4'd6;
            11: left_note = 4'd4;
            12: left_note = 4'd6;

            13: left_note = 4'd1;
            14: left_note = 4'd5;
            15: left_note = 4'd3;
            16: left_note = 4'd5;

            17: left_note = 4'd9; //low 7
            18: left_note = 4'd4;
            19: left_note = 4'd2;
            20: left_note = 4'd4;

            21: left_note = 4'd1;
            22: left_note = 4'd5;
            23: left_note = 4'd3;
            24: left_note = 4'd5;

            25: left_note = 4'd9;
            26: left_note = 4'd5;
            27: left_note = 4'd2;
            28: left_note = 4'd5;

            29: left_note = 4'd1;
            30: left_note = 4'd5;
            31: left_note = 4'd3;
            32: left_note = 4'd5;

            33: left_note = 4'd1;
            34: left_note = 4'd5;
            35: left_note = 4'd3;
            36: left_note = 4'd5;

            37: left_note = 4'd7;
            38: left_note = 4'd4;
            39: left_note = 4'd2;
            40: left_note = 4'd4;

            41: left_note = 4'd1;
            42: left_note = 4'd5;
            43: left_note = 4'd3;
            44: left_note = 4'd5;

            45: left_note = 4'd7;
            46: left_note = 4'd5;
            47: left_note = 4'd2;
            48: left_note = 4'd5;

            49: left_note = 4'd1;
            50: left_note = 4'd5;
            51: left_note = 4'd3;
            52: left_note = 4'd5;

            53: left_note = 4'd7;
            54: left_note = 4'd4;
            55: left_note = 4'd2;
            56 : left_note = 4'd4;

            57: left_note = 4'd1;
            58: left_note = 4'd5;
            59: left_note = 4'd3;
            60: left_note = 4'd5;

            61: left_note = 4'd7;
            62: left_note = 4'd5;
            63: left_note = 4'd2;
            64: left_note = 4'd5;

            65: left_note = 4'd1;
            66: left_note = 4'd5;
            67: left_note = 4'd3;
            68: left_note = 4'd5;

            69: left_note = 4'd1;
            70: left_note = 4'd5;
            71: left_note = 4'd3;
            72: left_note = 4'd5;

            73: left_note = 4'd1;
            74: left_note = 4'd6;
            75: left_note = 4'd4;
            76: left_note = 4'd6;

            77: left_note = 4'd1;
            78: left_note = 4'd5;
            79: left_note = 4'd3;
            80: left_note = 4'd5;

            81: left_note = 4'd7;
            82: left_note = 4'd4;
            83: left_note = 4'd2;
            84: left_note = 4'd4;

            85: left_note = 4'd8; //low_5
            86: left_note = 4'd3;
            87: left_note = 4'd1;
            88: left_note = 4'd3;

            89: left_note = 4'd8;
            90: left_note = 4'd2;
            91: left_note = 4'd9;
            92: left_note = 4'd2;

            93: left_note = 4'd1;
            94: left_note = 4'd1;
            95: left_note = 4'd1;
            96: left_note = 4'd1;

            default left_note = 4'd0;
        endcase
    end

endmodule
