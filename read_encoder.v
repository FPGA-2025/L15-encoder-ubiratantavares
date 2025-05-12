module Read_Encoder (
    input wire clk,
    input wire rst_n,

    input wire A,
    input wire B,

    output reg [1:0] dir
);

    reg [1:0] state;
    reg [1:0] next_state;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state = 2'b00; // Initial state
            next_state = 2'b00;
            dir = 2'b00; // No direction
        end else begin
            next_state = state;
            state = {A, B}; 

            case ({next_state, state})
                4'b0001, 4'b0111, 4'b1110, 4'b1000: dir = 2'b10; // Clockwise
                4'b0010, 4'b1011, 4'b1101, 4'b0100: dir = 2'b01; // Counter-clockwise
                default: dir = 2'b00; // No direction
            endcase

            next_state = state; // Update state
        end
    end
    
endmodule
