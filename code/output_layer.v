`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Design Name: Output Layer
// Module Name: output_layer
// Description: The output layer instantiates p_width number of neurons. The input 
// weight to the output layer is p_width*neurons*precision. Each neuron takes only
// p_width*precision width weight. Refer to the Figure 6 and 7 to see the organization
// of weights of each neuron in the weights and bias files. Interface the appropriate
// neuron and the appropriate weights and bias. 
//////////////////////////////////////////////////////////////////////////////////


module output_layer#(
    neurons = 10,                                   // number of neurons in this layer
    p_width = 10,                                   // number of neurons in the previous layer
    prec = 16                                       // Precision of the binary numbers. Set to 16 (Do not Change)
    )(
    input wire signed [(prec*p_width)-1:0] ip,               // Flattenned input from the previous layer. Width = neurons of previous layer * precision 
    output wire signed [(prec*neurons)-1:0] op,              // output of the current layer. Width = neurons of this layer * precision 
    input wire signed [(prec*p_width*neurons)-1:0] weights,  // flattenned weights of the current layer. This holds all the weights of each neuron of the layer. Width = neurons of previous layer* neurons of this layer* precision  
    input wire signed [(prec*neurons)-1:0] bias              // flattenned bias of the neurons. Width = neurons of this layer * precision
    );
    
/////////////////Write your code here//////////////////////////////////////

// Use a generate statement similar to the one used in neuron.v and a for loop 
// to create neurons number of instantiations and interface the appropriate weights
// and biases
    genvar i;
    
    generate
        for(i = 0; i < neurons; i = i + 1) begin : myNeurons
            neuron #(p_width, prec) n0(ip,op[(prec*(i+1)-1):prec*i] , weights[(prec*p_width*(i+1)-1):prec*p_width*i], bias[(prec*(i+1)-1):prec*i]);
        end
    endgenerate
    
//////////////////////// Code ends/////////////////////////////////////          
    
endmodule
