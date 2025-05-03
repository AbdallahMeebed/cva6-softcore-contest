module bne (
  input logic [7:0] a,
  output logic [2:0] y,
  output logic q
  );

  assign q = &a;
  assign y[2] = &a[3:0];
  assign y[1] = &a[1:0] & (~a[2] | ~a[3] | (a[4] & a[5]));
  assign y[0] = (a[0] & (~a[1] | (a[2] & ~a[3]))) | (a[0] & a[2] & a[4] & (~a[5] | a[6]));

endmodule
