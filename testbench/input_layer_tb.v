`timescale 1ns/1ns
//////////////////////////////////////////////////////////////////////////////////
// Design Name: Input Layer Testbench
// Module Name: input_layer_tb.v
// Description: This testbench runs provides an input to the input layer and verifies its
// oprations
//////////////////////////////////////////////////////////////////////////////////

module input_layer_tb();

    parameter neurons = 4;          // Dimensions of the input image =  number of neurons in the input layer
    parameter prec = 16;            // Precision of the binary numbers (Do not Change)                  
    reg [(neurons*prec)-1:0] ip;    // Input to the input layer                            
    wire [(neurons*prec)-1:0] op;   // output of the output layer


    input_layer#(
        .neurons(neurons),
        .prec(prec)
    )DUT(
        .ip(ip),         
        .op(op)                                
    );

// The output will be printed on the tcl console below

    initial begin
        ip = 'b00000000_1111110000000000_0010110000000000_0110110000000000_10000000;
        #5
        if(op == ip)
            $display("The module input_layer.v works as intended");
        else
            $display("The module input_layer.v does not work as intended");
        #5
        $finish;
    end

endmodule
 

