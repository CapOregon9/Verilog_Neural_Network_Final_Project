`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Design Name: Neural network Testbench
// Module Name: neural_network_tb.v
// Description: This testbench runs provides an input to the neural networkand verifies its
// operations
//////////////////////////////////////////////////////////////////////////////////
module neural_network_tb();

    parameter prec = 16;                                        // Precision of the binary numbers (Do not Change)
    parameter imgdim = 784;                                     // Dimension of the flatenned input image (Do not change)
    parameter l1 = 30;                                          // Number of neurons in the hidden layer (Do not change)
    parameter l2 = 10;                                          // Number of neurons in the output layer (Do not change)
    
    
    reg [((imgdim*l1))*prec - 1:0] weights_hidden[0:0];          // Weights of the hidden layer 
    reg [prec*(l1) - 1:0] bias_hidden[0:0];                     // Bias of the hidden layer
    reg [((l2*l1))*prec - 1:0] weights_output[0:0] ;             // Weights of the output layer
    reg [prec*(l2) - 1:0] bias_output[0:0];                     // Bias of the output layer
    reg [prec*imgdim-1:0] ip[0:0] ;                             // Input image
    wire [l2*prec-1:0]op;                                       // Activations of the output layer
    wire [5:0] prediction;                                      // Predicted label of the input image
    
    neural_network#(
        .imgdim(imgdim),
        .l1(l1),
        .l2(l2),
        .prec(prec)
    )Network(
        .weights_hidden(weights_hidden[0]),
        .bias_hidden(bias_hidden[0]),
        .weights_output(weights_output[0]),
        .bias_output(bias_output[0]),
        .ip(ip[0]),
        .op(op),
        .prediction(prediction)
    );
    
    initial begin
        $readmemb("D:/Documents/EEL4783_VHDL/project/images/image_0.txt",ip);
        $readmemb("D:/Documents/EEL4783_VHDL/project/weights/weights_hidden.txt",weights_hidden);
        $readmemb("D:/Documents/EEL4783_VHDL/project/weights/weights_output.txt",weights_output);
        $readmemb("D:/Documents/EEL4783_VHDL/project/bias/bias_hidden.txt",bias_hidden);
        $readmemb("D:/Documents/EEL4783_VHDL/project/bias/bias_output.txt",bias_output);
        #5
        if(prediction == 5)
            $display("The module neural_network.v works as intended");
        else
            $display("The module neural_network.v does not work as intended");
    end
    
endmodule    

    
