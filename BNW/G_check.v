`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/24 16:25:50
// Design Name: 
// Module Name: G_check
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - Gile Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module G_check( /*input*/ beat_cnt,  /*output*/ G_check );

    input [6:0] beat_cnt;
    output reg [5:0] G_check;

    always@*
    begin
        case( beat_cnt )
            1: G_check = 6'd1;
            2: G_check = 6'd2;
            3: G_check = 6'd2;
            4: G_check = 6'd2;

            5: G_check = 6'd3;
            6: G_check = 6'd4;
            7: G_check = 6'd4;
            8: G_check = 6'd4;

            9: G_check = 6'd5;
            10: G_check = 6'd6;
            11: G_check = 6'd6;
            12: G_check = 6'd6;

            13: G_check = 6'd7;
            14: G_check = 6'd8;
            15: G_check = 6'd9;
            16: G_check = 6'd10;

            17: G_check = 6'd10;
            18: G_check = 6'd10;
            19: G_check = 6'd11;
            20: G_check = 6'd12;

            21: G_check = 6'd12;
            22: G_check = 6'd12;
            23: G_check = 6'd13;
            24: G_check = 6'd14;

            25: G_check = 6'd14;
            26: G_check = 6'd14;
            27: G_check = 6'd15;
            28: G_check = 6'd16;

            29: G_check = 6'd16;
            30: G_check = 6'd16;
            31: G_check = 6'd16;
            32: G_check = 6'd16;

            33: G_check = 6'd17;
            34: G_check = 6'd18;
            35: G_check = 6'd18;
            36: G_check = 6'd19;

            37: G_check = 6'd19;
            38: G_check = 6'd20;
            39: G_check = 6'd20;
            40: G_check = 6'd21;

            41: G_check = 6'd21;
            42: G_check = 6'd21;
            43: G_check = 6'd22;
            44: G_check = 6'd23;

            45: G_check = 6'd23;
            46: G_check = 6'd23;
            47: G_check = 6'd24;
            48: G_check = 6'd25;

            49: G_check = 6'd25;
            50: G_check = 6'd26;
            51: G_check = 6'd26;
            52: G_check = 6'd27;

            53: G_check = 6'd27;
            54: G_check = 6'd28;
            55: G_check = 6'd28;
            56 : G_check = 6'd29;

            57: G_check = 6'd29;
            58: G_check = 6'd30;
            59: G_check = 6'd30;
            60: G_check = 6'd31;

            61: G_check = 6'd31;
            62: G_check = 6'd32;
            63: G_check = 6'd32;
            64: G_check = 6'd33;

            65: G_check = 6'd33;
            66: G_check = 6'd33;
            67: G_check = 6'd34;
            68: G_check = 6'd35;

            69: G_check = 6'd35;
            70: G_check = 6'd35;
            71: G_check = 6'd36;
            72: G_check = 6'd37;

            73: G_check = 6'd37;
            74: G_check = 6'd38;
            75: G_check = 6'd38;
            76: G_check = 6'd39;

            77: G_check = 6'd39;
            78: G_check = 6'd40;
            79: G_check = 6'd40;
            80: G_check = 6'd41;

            81: G_check = 6'd41;
            82: G_check = 6'd41;
            83: G_check = 6'd41;
            84: G_check = 6'd42;

            85: G_check = 6'd43;
            86: G_check = 6'd43;
            87: G_check = 6'd43;
            88: G_check = 6'd44;

            89: G_check = 6'd44;
            90: G_check = 6'd45;
            91: G_check = 6'd45;
            92: G_check = 6'd45;

            93: G_check = 6'd46;
            94: G_check = 6'd47;
            95: G_check = 6'd48;
            96: G_check = 6'd49;


            default G_check = 6'd0;
        endcase
    end

endmodule
