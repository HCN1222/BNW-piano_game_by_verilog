`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/24 16:25:50
// Design Name: 
// Module Name: F_check
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


module F_check( /*input*/ beat_cnt,  /*output*/ F_check );

    input [6:0] beat_cnt;
    output reg [5:0] F_check;

    always@*
    begin
        case( beat_cnt )
            1: F_check = 6'd0;
            2: F_check = 6'd0;
            3: F_check = 6'd1;
            4: F_check = 6'd2;

            5: F_check = 6'd2;
            6: F_check = 6'd2;
            7: F_check = 6'd3;
            8: F_check = 6'd4;

            9: F_check = 6'd4;
            10: F_check = 6'd4;
            11: F_check = 6'd5;
            12: F_check = 6'd6;

            13: F_check = 6'd6;
            14: F_check = 6'd6;
            15: F_check = 6'd6;
            16: F_check = 6'd6;

            17: F_check = 6'd7;
            18: F_check = 6'd8;
            19: F_check = 6'd8;
            20: F_check = 6'd8;

            21: F_check = 6'd9;
            22: F_check = 6'd10;
            23: F_check = 6'd10;
            24: F_check = 6'd10;

            25: F_check = 6'd11;
            26: F_check = 6'd12;
            27: F_check = 6'd12;
            28: F_check = 6'd12;

            29: F_check = 6'd13;
            30: F_check = 6'd14;
            31: F_check = 6'd15;
            32: F_check = 6'd16;

            33: F_check = 6'd16;
            34: F_check = 6'd17;
            35: F_check = 6'd17;
            36: F_check = 6'd17;

            37: F_check = 6'd18;
            38: F_check = 6'd19;
            39: F_check = 6'd19;
            40: F_check = 6'd19;

            41: F_check = 6'd20;
            42: F_check = 6'd21;
            43: F_check = 6'd21;
            44: F_check = 6'd21;

            45: F_check = 6'd22;
            46: F_check = 6'd23;
            47: F_check = 6'd23;
            48: F_check = 6'd23;

            49: F_check = 6'd24;
            50: F_check = 6'd25;
            51: F_check = 6'd25;
            52: F_check = 6'd25;

            53: F_check = 6'd26;
            54: F_check = 6'd27;
            55: F_check = 6'd27;
            56 : F_check = 6'd27;

            57: F_check = 6'd28;
            58: F_check = 6'd29;
            59: F_check = 6'd29;
            60: F_check = 6'd29;

            61: F_check = 6'd30;
            62: F_check = 6'd31;
            63: F_check = 6'd31;
            64: F_check = 6'd31;

            65: F_check = 6'd32;
            66: F_check = 6'd32;
            67: F_check = 6'd33;
            68: F_check = 6'd33;

            69: F_check = 6'd34;
            70: F_check = 6'd34;
            71: F_check = 6'd35;
            72: F_check = 6'd35;

            73: F_check = 6'd36;
            74: F_check = 6'd37;
            75: F_check = 6'd37;
            76: F_check = 6'd37;

            77: F_check = 6'd38;
            78: F_check = 6'd39;
            79: F_check = 6'd39;
            80: F_check = 6'd39;

            81: F_check = 6'd40;
            82: F_check = 6'd40;
            83: F_check = 6'd40;
            84: F_check = 6'd41;

            85: F_check = 6'd41;
            86: F_check = 6'd42;
            87: F_check = 6'd42;
            88: F_check = 6'd42;

            89: F_check = 6'd42;
            90: F_check = 6'd42;
            91: F_check = 6'd43;
            92: F_check = 6'd44;

            93: F_check = 6'd44;
            94: F_check = 6'd44;
            95: F_check = 6'd44;
            96: F_check = 6'd44;


            default F_check = 6'd0;
        endcase
    end

endmodule
