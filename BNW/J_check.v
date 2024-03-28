`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/24 16:25:50
// Design Name: 
// Module Name: J_check
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


module J_check( /*input*/ beat_cnt,  /*output*/ J_check );

    input [6:0] beat_cnt;
    output reg [5:0] J_check;

    always@*
    begin
        case( beat_cnt )
            1: J_check = 6'd1;
            2: J_check = 6'd2;
            3: J_check = 6'd2;
            4: J_check = 6'd2;

            5: J_check = 6'd3;
            6: J_check = 6'd4;
            7: J_check = 6'd4;
            8: J_check = 6'd4;

            9: J_check = 6'd5;
            10: J_check = 6'd6;
            11: J_check = 6'd6;
            12: J_check = 6'd6;

            13: J_check = 6'd7;
            14: J_check = 6'd8;
            15: J_check = 6'd9;
            16: J_check = 6'd10;

            17: J_check = 6'd10;
            18: J_check = 6'd10;
            19: J_check = 6'd11;
            20: J_check = 6'd12;

            21: J_check = 6'd12;
            22: J_check = 6'd12;
            23: J_check = 6'd13;
            24: J_check = 6'd14;

            25: J_check = 6'd14;
            26: J_check = 6'd14;
            27: J_check = 6'd15;
            28: J_check = 6'd16;

            29: J_check = 6'd16;
            30: J_check = 6'd16;
            31: J_check = 6'd16;
            32: J_check = 6'd16;

            33: J_check = 6'd17;
            34: J_check = 6'd17;
            35: J_check = 6'd18;
            36: J_check = 6'd19;

            37: J_check = 6'd19;
            38: J_check = 6'd19;
            39: J_check = 6'd20;
            40: J_check = 6'd21;

            41: J_check = 6'd21;
            42: J_check = 6'd22;
            43: J_check = 6'd22;
            44: J_check = 6'd23;

            45: J_check = 6'd23;
            46: J_check = 6'd24;
            47: J_check = 6'd24;
            48: J_check = 6'd25;

            49: J_check = 6'd25;
            50: J_check = 6'd25;
            51: J_check = 6'd26;
            52: J_check = 6'd27;

            53: J_check = 6'd27;
            54: J_check = 6'd27;
            55: J_check = 6'd28;
            56 : J_check = 6'd29;

            57: J_check = 6'd29;
            58: J_check = 6'd29;
            59: J_check = 6'd30;
            60: J_check = 6'd31;

            61: J_check = 6'd31;
            62: J_check = 6'd31;
            63: J_check = 6'd32;
            64: J_check = 6'd33;

            65: J_check = 6'd33;
            66: J_check = 6'd34;
            67: J_check = 6'd34;
            68: J_check = 6'd35;

            69: J_check = 6'd35;
            70: J_check = 6'd36;
            71: J_check = 6'd36;
            72: J_check = 6'd37;

            73: J_check = 6'd37;
            74: J_check = 6'd37;
            75: J_check = 6'd38;
            76: J_check = 6'd39;

            77: J_check = 6'd39;
            78: J_check = 6'd39;
            79: J_check = 6'd40;
            80: J_check = 6'd41;

            81: J_check = 6'd41;
            82: J_check = 6'd41;
            83: J_check = 6'd41;
            84: J_check = 6'd42;

            85: J_check = 6'd42;
            86: J_check = 6'd42;
            87: J_check = 6'd42;
            88: J_check = 6'd43;

            89: J_check = 6'd43;
            90: J_check = 6'd43;
            91: J_check = 6'd43;
            92: J_check = 6'd43;

            93: J_check = 6'd44;
            94: J_check = 6'd45;
            95: J_check = 6'd46;
            96: J_check = 6'd47;


            default J_check = 6'd0;
        endcase
    end

endmodule
