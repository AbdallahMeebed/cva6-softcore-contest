module lzc32 #(
  /// The width of the input vector.
  parameter int unsigned WIDTH = 32,
  /// Mode selection: 0 -> trailing zero, 1 -> leading zero
  parameter bit          MODE  = 1'b0,
  parameter int unsigned CNT_WIDTH = cf_math_pkg::idx_width(WIDTH)
) (
  /// Input vector to be counted.
  input  logic [WIDTH-1:0]     in_i,
  /// Count of the leading / trailing zeros.
  output logic [CNT_WIDTH-1:0] cnt_o,
  /// Counter is empty: Asserted if all bits in in_i are zero.
  output logic                 empty_o
);

logic [WIDTH-1:0] in_tmp;
logic [7:0] a;
logic [15:0] z;
logic [2:0] y;

// reverse vector if required
always_comb begin : flip_vector
  for (int unsigned i = 0; i < WIDTH; i++) begin
    in_tmp[i] = (MODE) ? in_i[WIDTH-1-i] : in_i[i];
  end
end

genvar i;
generate for (i = 0; i < 8; i += 1) begin: gen_nlc
  nlc i_nlc(
    .x(in_tmp[4*i + 3: 4*i]),
    .a(a[i]),
    .z(z[2*i + 1 : 2*i])
    );
end
endgenerate

bne i_bne(
  .a(a),
  .y(y),
  .q(empty_o)
  );

// Mux 8 with 2 width input
always_comb begin
  case (y)
    3'b000: cnt_o[1:0] = z[1:0];
    3'b001: cnt_o[1:0] = z[3:2];
    3'b010: cnt_o[1:0] = z[5:4];
    3'b011: cnt_o[1:0] = z[7:6];
    3'b100: cnt_o[1:0] = z[9:8];
    3'b101: cnt_o[1:0] = z[11:10];
    3'b110: cnt_o[1:0] = z[13:12];
    3'b111: cnt_o[1:0] = z[15:14];
  endcase
end

assign cnt_o[4:2] = y;
endmodule
