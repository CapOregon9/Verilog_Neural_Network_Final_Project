`timescale 1ns/1ns
//////////////////////////////////////////////////////////////////////////////////
// Design Name: Accuracy Testbench
// Module Name: accuracy_tb.sv
// Description: This testbench runs the neural network for 100 images stored
// in the "project/images" folder and calcuates the accuracy for these 100 images.
// The actual labels of each image is stored in "project/labels" folder and the 
// label of image_n.txt is in file label_n.txt. 
//////////////////////////////////////////////////////////////////////////////////
module accuracy_tb();

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
    reg [5:0] label[0:0];                                       // Actual label
    reg [31:0] correct = 0;                                     // Register to count the number of correct predictions
    reg [31:0] incorrect = 0;                                   // Register to count the number of incorrect predictions
    
    
    integer i;
/////////////////Write your code here//////////////////////////////////////
    reg [31:0] accuracy = 0; 
    static logic [7:0] imageInput[128];
    static logic [7:0] labelInput[128];
// Instantiate the neural network module
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
        $readmemb("D:/Documents/EEL4783_VHDL/project/weights/weights_hidden.txt",weights_hidden);
        $readmemb("D:/Documents/EEL4783_VHDL/project/weights/weights_output.txt",weights_output);
        $readmemb("D:/Documents/EEL4783_VHDL/project/bias/bias_hidden.txt",bias_hidden);
        $readmemb("D:/Documents/EEL4783_VHDL/project/bias/bias_output.txt",bias_output);
        for(i = 0; i < 100; i = i + 1) begin
            $sformat(imageInput,"D:/Documents/EEL4783_VHDL/project/images/image_%0d.txt",i);
            $readmemb(imageInput,ip); 
//            $readmemb($sformatf("D:/Documents/EEL4783_VHDL/project/images/image_%d.txt",i),ip);            
//            $readmemb($sformatf("D:/Documents/EEL4783_VHDL/project/labels/label_%d.txt",i),label);
            $sformat(labelInput,"D:/Documents/EEL4783_VHDL/project/labels/label_%0d.txt",i);
            $readmemb(labelInput,label);
            #5;
            if(prediction == label[0])                                                   
                correct = correct + 1;      
            else                                                                  
                incorrect = incorrect + 1;
            #5;
        end
        
        accuracy = ((correct * 100) / (correct + incorrect));
        
        $display($sformatf("The accuracy is %0d%%",accuracy));
    end
// Write an initial block and read the weights and bias of the network and store them in the 
// registers declared above using $readmemb("path_of_file/file.txt",ram). This function reads
// the file file.txt and stores its contents in the register ram. Use a for loop to read the 
// image file image_n.txt and the corresponding label label_n.txt. Compare the prediction and
// the actual label and calculate the accuracy of the network over 100 images.
// You can use string format specifier function $sformatf("path_of_file/image_%0d.txt",i) to format the
// string as "path_of_file/image_<i>.txt" where i is an integer.You can have the string format specifier
// function within the $readmemb and use a for loop to loop through reading each image and label file.
// Print the calculated accuracy below using $display function
// The following resources have more information about the required functions
// 1. https://projectf.io/posts/initialize-memory-in-verilog/
// 2. https://www.chipverify.com/verilog/verilog-display-tasks
//////////////////////// Code ends/////////////////////////////////////     

endmodule
