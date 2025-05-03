module nlc (
  input logic [3:0] x,
  output logic a,
  output logic [1:0] z
  );

  assign a = ~|x;
  assign z[1] = (x[3] | x[2]);
  assign z[0] = (x[3] | (x[1] & (~x[2])));

endmodule
