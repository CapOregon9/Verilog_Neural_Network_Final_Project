`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Design Name: Input Layer
// Module Name: input_layer
// Project Name: Neural Network
// Description: Input layer of the Neural Network wil configurable paramaters neurons and precision
//////////////////////////////////////////////////////////////////////////////////

module input_layer#(
        neurons = 784,                              //Size of the flattenned input image 
        prec = 16                                   //Precision of the binary numbers. Set to 16 (Do not Change)
    )(
    input wire[(prec*neurons)-1:0] ip,              // input to the Neural Network
    output wire [(prec*neurons)-1:0] op             // output of the input layer
    );
    
//////////////Write your code here/////////////////
assign op = ip;
///////////////////Code Ends///////////////////////

endmodule