`timescale 1ns/1ns
//////////////////////////////////////////////////////////////////////////////////
// Design Name: Predictor Testbench
// Module Name: predictor_tb.v
// Description: This testbench runs provides an input to the prediction layer and verifies its
// oprations
//////////////////////////////////////////////////////////////////////////////////

module predictor_tb();

    parameter final_width = 4;      // Number of neurons of the final layer
    parameter prec = 16;            // Precision of the binary numbers (Do not Change)                  
    reg [(final_width*prec)-1:0] ip;    // Input to the predictor layer                            
    wire [(final_width*prec)-1:0] op;   // output of the predictor layer
    wire [5:0] prediction;          // Prediction of the neural network

    predictor#(
        .final_width(final_width),
        .prec(prec)
    )DUT(
        .ip(ip),         
        .op(op),
        .prediction(prediction)                                
    );
    
// The output will be printed on the tcl console below

    initial begin
        ip = 'b00000000_0000000000000000_0010110000000000_0110110000000000_00101100;
        #5
        if((op == ip)&&(prediction == 2))
            $display("The module predictor.v works as intended");
        else
            $display("The module predictor.v does not work as intended");
//        #5
//        $finish;
    end

endmodule
 

