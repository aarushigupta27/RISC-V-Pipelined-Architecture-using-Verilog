module ALU(input [31:0] A,B,input [2:0] alu_control,output overflow,carry,zero,negative, output [31:0]result);
    wire cout;
    wire [31:0]sum;
    assign sum=(alu_control[0]==1'b0)?A+B:(A+((~B)+1)) ;
    assign {cout,result} = (alu_control==3'b000)?sum :
                           (alu_control==3'b001)?sum :
                           (alu_control==3'b010)?A&B :
                           (alu_control==3'b011)?A|B :
                           (alu_control==3'b101)?{{32{1'b0}},(sum[31])} :
                           {33{1'b0}};
    assign overflow = ((sum[31]^A[31]) & 
                      (~(alu_control[0]^B[31]^A[31])) &
                      (~alu_control[1]));
    assign carry=((~alu_control[1]) & cout);
    assign zero=&(~result);
    assign negative=result[31];

endmodule
