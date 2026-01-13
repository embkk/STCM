import testbench_pkg::*;

module deserializer (
  input   logic         clk_i,
  input   logic         srst_i,
  input   logic         data_i,
  input   logic         data_val_i,
  output  logic[15:0]   deser_data_o,
  output  logic         deser_data_val_o
);

logic[3:0] counter = 4'b0000;

// #1 - change state block
always_ff @( posedge clk_i )
  begin
    if( srst_i )
      begin
        deser_data_o     <= '{1'b0};
        deser_data_val_o <= 1'b0;
      end
    else
      begin
        if(deser_data_val_o)
          deser_data_val_o <= 1'b0;

        if(data_val_i)
        begin
          //$display("Counter %0d", counter);
          //$display("Input %0d Counter %0d Reg %b", data_i, counter, deser_data_o);
          //$display("Reg %b\n", deser_data_o);
          //$display("Output %b", deser_data_o);
          deser_data_o[counter]  <= data_i;
          counter                <= (counter + 1);

          deser_data_val_o <= counter == 15 ? 1'b1 : 1'b0; 
        end

      end
  end

endmodule