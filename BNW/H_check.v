`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/24 16:25:50
// Design Name: 
// Module Name: H_check
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - Hile Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module H_check( /*input*/ beat_cnt,  /*output*/ H_check );

    input [6:0] beat_cnt;
    output reg [5:0] H_check;

    always@*
    begin
        case( beat_cnt )
            1: H_check = 6'd0;
            2: H_check = 6'd0;
            3: H_check = 6'd1;
            4: H_check = 6'd2;

            5: H_check = 6'd2;
            6: H_check = 6'd2;
            7: H_check = 6'd3;
            8: H_check = 6'd4;

            9: H_check = 6'd4;
            10: H_check = 6'd4;
            11: H_check = 6'd5;
            12: H_check = 6'd6;

            13: H_check = 6'd6;
            14: H_check = 6'd6;
            15: H_check = 6'd6;
            16: H_check = 6'd6;

            17: H_check = 6'd7;
            18: H_check = 6'd8;
            19: H_check = 6'd8;
            20: H_check = 6'd8;

            21: H_check = 6'd9;
            22: H_check = 6'd10;
            23: H_check = 6'd10;
            24: H_check = 6'd10;

            25: H_check = 6'd11;
            26: H_check = 6'd12;
            27: H_check = 6'd12;
            28: H_check = 6'd12;

            29: H_check = 6'd13;
            30: H_check = 6'd14;
            31: H_check = 6'd15;
            32: H_check = 6'd16;

            33: H_check = 6'd16;
            34: H_check = 6'd16;
            35: H_check = 6'd17;
            36: H_check = 6'd17;

            37: H_check = 6'd18;
            38: H_check = 6'd18;
            39: H_check = 6'd19;
            40: H_check = 6'd19;

            41: H_check = 6'd20;
            42: H_check = 6'd20;
            43: H_check = 6'd21;
            44: H_check = 6'd21;

            45: H_check = 6'd22;
            46: H_check = 6'd22;
            47: H_check = 6'd23;
            48: H_check = 6'd23;

            49: H_check = 6'd24;
            50: H_check = 6'd24;
            51: H_check = 6'd25;
            52: H_check = 6'd25;

            53: H_check = 6'd26;
            54: H_check = 6'd26;
            55: H_check = 6'd27;
            56 : H_check = 6'd27;

            57: H_check = 6'd28;
            58: H_check = 6'd28;
            59: H_check = 6'd29;
            60: H_check = 6'd29;

            61: H_check = 6'd30;
            62: H_check = 6'd30;
            63: H_check = 6'd31;
            64: H_check = 6'd31;

            65: H_check = 6'd32;
            66: H_check = 6'd33;
            67: H_check = 6'd33;
            68: H_check = 6'd33;

            69: H_check = 6'd34;
            70: H_check = 6'd35;
            71: H_check = 6'd35;
            72: H_check = 6'd35;

            73: H_check = 6'd36;
            74: H_check = 6'd36;
            75: H_check = 6'd37;
            76: H_check = 6'd37;

            77: H_check = 6'd38;
            78: H_check = 6'd38;
            79: H_check = 6'd39;
            80: H_check = 6'd39;

            81: H_check = 6'd39;
            82: H_check = 6'd39;
            83: H_check = 6'd40;
            84: H_check = 6'd40;

            85: H_check = 6'd40;
            86: H_check = 6'd40;
            87: H_check = 6'd41;
            88: H_check = 6'd41;

            89: H_check = 6'd42;
            90: H_check = 6'd42;
            91: H_check = 6'd43;
            92: H_check = 6'd44;

            93: H_check = 6'd44;
            94: H_check = 6'd44;
            95: H_check = 6'd44;
            96: H_check = 6'd44;


            default H_check = 6'd0;
        endcase
    end

endmodule
