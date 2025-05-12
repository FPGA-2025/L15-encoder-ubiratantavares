module Encoder (
    input wire clk,
    input wire rst_n,

    input wire horario,
    input wire antihorario,

    output reg A,
    output reg B
);

    reg [1:0] state;

    // estados codificados em quadratura
    // horario: 00 -> 10 -> 11 -> 01 -> 00
    // antihorario: 00 -> 01 -> 11 -> 10 -> 00

    // atualiza A e B de acordo com o estado atual
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state = 2'b00;        
        end else begin
            if (!horario && antihorario) begin
                case (state)
                    2'b00: state = 2'b01;
                    2'b01: state = 2'b11;
                    2'b11: state = 2'b10;
                    2'b10: state = 2'b00;
                    default: state = 2'b00;
                endcase
            end else if (horario && !antihorario) begin
                case (state)
                    2'b00: state = 2'b10;
                    2'b10: state = 2'b11;
                    2'b11: state = 2'b01;
                    2'b01: state = 2'b00;
                    default: state = 2'b00;
                endcase
            end
        end
    end

    // A e B mapeados diretamente dos estados   
    always @(*) begin
        A = state[1];
        B = state[0];
    end

endmodule
