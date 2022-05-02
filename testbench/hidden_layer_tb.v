`timescale 1ns/1ns
//////////////////////////////////////////////////////////////////////////////////
// Design Name: Hidden layer Testbench
// Module Name: hidden_layer_tb.v
// Description: This testbench runs provides an input to the hidden layer and verifies its
// operations
//////////////////////////////////////////////////////////////////////////////////

module hidden_layer_tb();

    parameter prec = 16;                    // Precision of the binary numbers (Do not Change)
    parameter p_width = 2;                  // Number of neurons in the previous layer (Do not change)
    parameter neurons = 2;                  // Number of neurons of the hidden layer (Do not change)
    
    reg [(prec*p_width)-1:0] ip;                // input from the previous layer
    wire[(prec*neurons)-1:0] op;               // output of the current layer
    reg [(prec*p_width*neurons)-1:0] weights;   // flattenned weights of the current layer 
    reg [(prec*neurons)-1:0] bias;               // flattenned bias of the neurons


    hidden_layer#(
        .p_width(p_width),
        .prec(prec),
        .neurons(neurons)
    )DUT(
        .ip(ip),         
        .op(op),                    
        .weights(weights),   
        .bias(bias)                  
    );

    initial begin
        weights ='b11111111_0101000011111111_1001000011111111_1111010011111111_10110110;
        ip = 'b00000000_1111110000000000_00101100;
        bias = 'b00000000_1111001100000000_11110011;
        #5
        if(op == 'b00101000001100010010100011011010)
            $display("The module hidden_layer.v works as intended");
        else
            $display("The module hidden_layer.v does not work as intended");
        #5
        $finish;
    end

endmodule
 

