module top_tb;

logic [1:0] in0, in1, in2, in3;
logic [1:0] sel;
logic [1:0] mux_out;

bit test_passed = 1;

mux4 mux4_inst (
  in0,
  in1,
  in2,
  in3,
  sel,
  mux_out
);

initial
  begin

    for (int sel_val = 0; sel_val < 4; sel_val++) begin
      for (int in0_val = 0; in0_val < 4; in0_val++) begin
        for (int in1_val = 0; in1_val < 4; in1_val++) begin
          for (int in2_val = 0; in2_val < 4; in2_val++) begin
            for (int in3_val = 0; in3_val < 4; in3_val++) begin

              sel = sel_val;
              in0 = in0_val;
              in1 = in1_val;
              in2 = in2_val;
              in3 = in3_val;

              #10;

              case (sel)
                2'b00:
                if (mux_out != in0)
                  begin
                    test_passed = 0;
                    $display("Error: sel=%b, in0=%b, in1=%b, in2=%b, in3=%b, mux_out=%b", sel, in0, in1, in2, in3, mux_out);
                    break;
                  end

                2'b01:
                if (mux_out != in1)
                  begin
                    test_passed = 0;
                    $display("Error: sel=%b, in0=%b, in1=%b, in2=%b, in3=%b, mux_out=%b", sel, in0, in1, in2, in3, mux_out);
                    break;
                  end

                2'b10:
                  if (mux_out != in2)
                    begin
                      test_passed = 0;
                      $display("Error: sel=%b, in0=%b, in1=%b, in2=%b, in3=%b, mux_out=%b", sel, in0, in1, in2, in3, mux_out);
                      break;
                    end

                2'b11:
                  if (mux_out != in3)
                    begin
                      test_passed = 0;
                      $display("Error: sel=%b, in0=%b, in1=%b, in2=%b, in3=%b, mux_out=%b", sel, in0, in1, in2, in3, mux_out);
                      break;
                    end

                default:
                  begin
                    test_passed = 0;
                    $display("Error. Unkown selector in. sel=%b, in0=%b, in1=%b, in2=%b, in3=%b, mux_out=%b", sel, in0, in1, in2, in3, mux_out);
                  end

              endcase;

            end
          end
        end
      end
    end

    if (test_passed)
      $display("Test completed. No errors detected");
    else
      $display("Test failed. Errors above");

  end

endmodule