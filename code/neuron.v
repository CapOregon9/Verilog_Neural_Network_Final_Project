`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Design Name: Neuron
// Module Name: neuron
// Project Name: Neural Network
// Description: The neuron has to perform p_width 16-bit multiplications and add 
//              the resultant values together along with the bias.
//////////////////////////////////////////////////////////////////////////////////


module neuron #(
    parameter p_width = 10,                             // Number of neurons of the previous layer
    parameter prec = 16                                 // Precision of the binary numbers. Set to 16 (Do not Change)
    )(
    input   wire signed [(prec*p_width)-1:0] ip,        // flattenned input to the neuron. The neurons recives the output of every neuron from the previous layer. Width = neurons of previous layer * precision 
    output  reg signed [prec-1:0] op,                   // 16 bit output of the neuron
    input   wire signed [(prec*p_width)-1:0] weights,   // flattenned weights. Width = neurons of previous layer * precision   
    input   wire signed [prec-1:0] bias                 // 16 bit bias 
    );
    
    wire signed [(2*prec*p_width)-1:0] mult;        //Each 16 bit multiplication will result in a 32 bit number that is trimmed to 16 bits.This temporarily holds the 32 bit values of p_width multiplications  
                                                    //Read the resources linked in section 3.2 of the project instructions for more details about multiplications
/////////////////Write your code here//////////////////////////////////////

// Use a generate statement and a for loop to create p_width number of statements 
// that each performs 16 bit multiplications using each input and weight  
  
    genvar i;
    
    generate
        for(i = 0; i < p_width; i = i + 1) begin
            assign mult[(2*(prec*(i + 1))) - 1:2*prec*i] = ip[(prec*(i + 1)) - 1:prec*i] * weights[(prec*(i + 1)) - 1:prec*i];
        end
    endgenerate
    
    
// Use an always block and a for loop to perform the addition of the result of the
// multiplication and the bias. 
// Hint: use blocking statements (=) so that each statement is executed one after another
// Hint: Vivado automatically unrolls the for loop and duplicates each statement. Use this
// to avoid typing all the statements manually  
  
    integer j;    
   
    always@(ip, weights, bias, mult) begin
        op = 0;
        for(j = 0; j < p_width; j = j + 1) begin
            op = op + mult[((2*prec*j)+(prec/2))+:prec];
        end
        op = op + bias;
    end    
//////////////////////// Code ends/////////////////////////////////////      
endmodule
