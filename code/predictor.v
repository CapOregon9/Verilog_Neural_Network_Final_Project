`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Design Name: Predictor
// Module Name: predictor
// Description: The predictor takes the final activations of the output layer and
// return the index of the neuron that has the highest activation. Due to our naming
// convention of the neurons, the activation of the 0th neuron is ip[15:0] and 1st neuron 
// is ip[31:16]. If the nth neuron has the highest activation, the prediction should be
// final_width - n-1.
//////////////////////////////////////////////////////////////////////////////////


module predictor#(
    final_width = 10,                               // Number of neurons of the final layer
    prec = 16                                       // Precision of the binary numbers. Set to 16 (Do not Change)
    )(
    input wire signed [(prec*final_width)-1:0] ip,  // Input to the predictor which is the activation of the output layer. Width = final_width*prec
    output wire signed [(prec*final_width)-1:0] op, // Activation of the final layer. This is just a passthrough of the input to the predictor
    output reg [5:0] prediction                     // Output that shows the final prediction of the network
    );
    
/////////////////Write your code here//////////////////////////////////////

// Use an always block and a for loop to go through the 16 bit activations of 
// each neuron and check if that is the maximum activation of the layer
// If it is return the index of the neuron. Due to our naming
// convention of the neurons, the activation of the 0th neuron is ip[15:0] and 1st neuron 
// is ip[31:16]. If the nth neuron has the highest activation, the prediction should be
// final_width - n-1.
 // Hint: use blocking statements (=) so that each statement is executed one after another
// Hint: Vivado automatically unrolls the for loop and duplicates each statement. Use this
// to avoid typing all the statements manually
integer j;

reg signed [(prec)-1:0] temp;

always @(*) begin
    prediction = 0;
    temp = ip[(prec)-1:0];
    for(j = 0; j < final_width; j = j + 1) begin
        if(ip[(prec*j)+:prec] > temp) begin
            prediction = j;
            temp = ip[(prec*j)+:prec];
        end
    end
    prediction = final_width - prediction - 1;
end
    
// Additonally, pass the activation of the final layer as an output of the predictor module 
assign op = ip;

//////////////////////// Code ends/////////////////////////////////////    

endmodule
