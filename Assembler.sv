`define _Number_instructions 524
module Assembler(output logic[19:0] address[`_Number_instructions], output logic operation_bit [`_Number_instructions]);
  
int num;
  
  function logic[19:0] str_to_logic(string s);     // to convert string into bitset
    
    logic[19:0] ans;
    
    for (int i = 0; i < 5; i++) begin
      num = char_to_int(s, 7-i);
      ans[4*i] = num%2;
      ans[4*i+1] = (num%4 - num%2)/2;
      ans[4*i+2] = (num%8 - num%4)/4;
      ans[4*i+3] = (num - num%8)/8;
    end
    return ans;
  endfunction
  
    function int char_to_int (string s, int x);
    int result;
    if (s[x] == "0")begin
        result = 0;
    end
    if (s[x] == "1")begin
        result = 1;
    end
    if (s[x] == "2")begin
        result = 2;
    end
    if (s[x] == "3")begin
        result = 3;
    end
    if (s[x] == "4")begin
        result = 4;
    end
    if (s[x] == "5")begin
        result = 5;
    end
    if (s[x] == "6")begin
        result = 6;
    end
    if (s[x] == "7")begin
        result = 7;
    end
    if (s[x] == "8")begin
        result = 8;
    end
    if (s[x] == "9")begin
        result = 9;
    end
    if (s[x] == "a")begin
        result = 10;
    end
    if (s[x] == "b")begin
        result = 11;
    end
    if (s[x] == "c")begin
        result = 12;
    end
    if (s[x] == "d")begin
        result = 13;
    end
    if (s[x] == "e")begin
        result = 14;
    end
    if (s[x] == "f")begin
        result = 15;
    end
    return result;
  endfunction
  
  initial begin
    string line, out_line;
    int input_file;
    input_file = $fopen("input.txt","r");
    
    for (int i = 0; i < `_Number_instructions; i++) begin
      $fgets(line, input_file);
      if (line[2] == "1") begin
        operation_bit[i] = 0;
      end
      else begin
        operation_bit[i] = 1;
      end
      address[i]=str_to_logic(line);
    end
    
    
    $fclose(input_file);
  end
  
endmodule