/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_example (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (0=input, 1=output)
    input  wire       ena,      // Always 1 when powered
    input  wire       clk,      // Clock
    input  wire       rst_n     // Active-low reset
);

  // Registered output to avoid GL test issues
  reg [7:0] result;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
      result <= 8'd0;
    else
      result <= ui_in[3:0] * ui_in[7:4];
  end

  assign uo_out = result;

  // IOs unused
  assign uio_out = 8'd0;
  assign uio_oe  = 8'd0;

  // Prevent unused warnings
  wire _unused = &{uio_in, ena, 1'b0};

endmodule