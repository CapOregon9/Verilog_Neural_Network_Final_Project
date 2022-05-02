`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Design Name: Neural Network
// Module Name: neural_network
// Description: The neural network module should instantiate the input layer, hidden
// layer, the output layer and the predictor modules. The network will take the weights
// bias of each layer as input along with the input image. It should also perform the 
// transfer of weights and bias and input to the corresponding layers. The outputs of 
// the predictor module will be the outputs of the network module
//////////////////////////////////////////////////////////////////////////////////


module neural_network#(
    imgdim = 784,                                       // Dimensions of the flattenned input image.(Do not change)
    l1 = 30,                                            // Number of neurons of the hidden layer. (Do not change)
    l2 = 10,                                            // Number of neurons of the output layer. (Do not change)
    prec = 16                                           // Precision of the binary numbers. Set to 16 (Do not Change)
    )(
    input wire signed [(l1*prec)-1:0] bias_hidden,      // bias of neurons in the hidden layer. Width = l1*prec
    input wire signed [(l2*prec)-1:0] bias_output,      // bias of neurons in the output layer. Width = l2*prec 
    input wire signed [(l1*imgdim)*prec-1:0] weights_hidden,    // weights of the neurons in the hidden layer. Width = imgdim*l1*prec
    input wire signed [(l1*l2)*prec-1:0] weights_output,        // weights of the neurons in the output layer. Width = l1*l2*prec
    input wire signed [(imgdim*prec)-1:0] ip,           // input image to the network. Width = imgdim*prec
    output wire signed [(prec*l2)-1:0] op,              // output of the network which is the activation of the final layer
    output wire [5:0] prediction                        // Prediction of the network for the input image
    );
 /////////////////Write your code here//////////////////////////////////////


// Instantiate input layer
wire signed [(imgdim*prec)-1:0] op1;
input_layer #(.neurons(imgdim), .prec(prec)) il(.ip(ip), .op(op1));

// Instantiate hidden layer
wire signed [(l1*prec)-1:0] op2;
hidden_layer #(.neurons(l1), .p_width(imgdim), .prec(prec)) hl(.ip(op1), .op(op2), .weights(weights_hidden), .bias(bias_hidden));
// Instantiate output layer
wire signed [(l2*prec)-1:0] op3;
output_layer #(.neurons(l2), .p_width(l1), .prec(prec)) ol(.ip(op2), .op(op3), .weights(weights_output), .bias(bias_output));
// Instantiate prediction module
predictor #(.final_width(l2), .prec(prec)) p1(.ip(op3), .op(op), .prediction(prediction));
//Tip: Make sure to perform proper interfacing between each module
// such that the output of the previous module/layer is fed into the next
// module/ layer 

//////////////////////// Code ends/////////////////////////////////////      

endmodule
