`timescale 1ns/1ns
//////////////////////////////////////////////////////////////////////////////////
// Design Name: Neuron Testbench
// Module Name: neuron_tb.v
// Description: This testbench runs provides an input to the neuron and verifies its
// operation
//////////////////////////////////////////////////////////////////////////////////

module neuron_tb();

    parameter prec = 16;                    // Precision of the binary numbers (Do not Change)
    parameter p_width = 4;                  // Number of neurons in the previous layer (Do not change)

    reg [(p_width*prec)-1:0] ip;            // Input to the neuron                            
    wire [prec-1:0] op;                     // output of the neuron
    reg [p_width*prec-1:0] weights;         // Input weights
    reg [prec-1:0] bias;                    // Input bias

    neuron#(
        .p_width(p_width),
        .prec(prec)
    )DUT(
        .ip(ip),         
        .op(op),                    
        .weights(weights),   
        .bias(bias)                  
    );

// The output will be printed on the tcl console below

    initial begin
        weights ='b11111111_0101000011111111_1001000011111111_1111010011111111_10110110;
        ip = 'b00000000_1111110000000000_0010110000000000_0110110000000000_10000000;
        bias = 'b00000000_11110011;
        #5
        if(op == 'b0001010000000110)
            $display("The module neuron.v works as intended");
        else
            $display("The module neuron.v does not work as intended");
        #5
        $finish;
    end

endmodule
 

