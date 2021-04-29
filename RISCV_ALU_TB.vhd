library IEEE;
use IEEE.std_logic_1164.all;
 
entity testbench is
end testbench; 

architecture tb of testbench is

component ulaRV is
generic(WSIZE: natural := 32);
port(
		opcode: 	in  std_logic_vector(3 downto 0);
		A, B:		in  std_logic_vector(WSIZE-1 downto 0);
		Z:			out std_logic_vector(WSIZE-1 downto 0);
		zero:		out std_logic);
end component;

signal a_in: std_logic_vector(31 downto 0);
signal b_in: std_logic_vector(31 downto 0);
signal z_out: std_logic_vector(31 downto 0);
signal zero_out: std_logic;
signal opcode_in: std_logic_vector(3 downto 0);

begin


  DUT: ulaRV port map(A => a_in, B => b_in, Z => z_out, opcode => opcode_in, zero => zero_out);

  process
  begin
  
  	report "***** inicio da simulacao *****";
    a_in <= x"00000001";
    b_in <= x"ffffffff";
    opcode_in <= "0000";
    wait for 1 ns;
    assert(z_out= x"00000000") report "Add error" severity error;
    
    a_in <= x"00000001";
    b_in <= x"00000002";
    opcode_in <= "0001";
    wait for 1 ns;
    assert(z_out= x"ffffffff") report "Sub error" severity error;
    
    a_in <= x"00001000";
    b_in <= x"ffffffff";
    opcode_in <= "0010";
    wait for 1 ns;
    assert(z_out= x"00001000") report "And error" severity error;   
    
    a_in <= x"00000001";
    b_in <= x"fffffffe";
    opcode_in <= "0011";
    wait for 1 ns;
    assert(z_out= x"ffffffff") report "Or error" severity error;
    
    a_in <= x"ffffffff";
    b_in <= x"a1b2c3d4";
    opcode_in <= "0100";
    wait for 1 ns;
    assert(z_out= x"5e4d3c2b") report "Xor error" severity error;
    
    a_in <= x"000000ff";
    b_in <= x"00000008";
    opcode_in <= "0101";
    wait for 1 ns;
    assert(z_out= x"0000ff00") report "Sll error" severity error;
    
    a_in <= x"ff000000";
    b_in <= x"00000008";
    opcode_in <= "0110";
    wait for 1 ns;
    assert(z_out= x"00ff0000") report "Srl error" severity error;
    
   	a_in <= x"ff000000";
    b_in <= x"00000008";
    opcode_in <= "0111";
    wait for 1 ns;
    assert(z_out= x"ffff0000") report "Sra error" severity error;
    
    a_in <= x"00000001";
    b_in <= x"ffffffff";
    opcode_in <= "1000";
    wait for 1 ns;
    assert(z_out= x"00000000") report "slt error" severity error;
    
    a_in <= x"00000001";
    b_in <= x"ffffffff";
    opcode_in <= "1001";
    wait for 1 ns;
    assert(z_out= x"00000001") report "Sltu error" severity error;
    
    a_in <= x"00000001";
    b_in <= x"00000001";
    opcode_in <= "1010";
    wait for 1 ns;
    assert(z_out= x"00000001") report "Sge error" severity error;
    
    a_in <= x"00000001";
    b_in <= x"ffffffff";
    opcode_in <= "1011";
    wait for 1 ns;
    assert(z_out= x"00000000") report "Sgeu error" severity error;
    
    a_in <= x"ffffffff";
    b_in <= x"ffffffff";
    opcode_in <= "1100";
    wait for 1 ns;
    assert(z_out= x"00000001") report "Seq error" severity error;
    
    a_in <= x"00000001";
    b_in <= x"ffffffff";
    opcode_in <= "1101";
    wait for 1 ns;
    assert(z_out= x"00000001") report "Sne error" severity error;
  
  
    assert false report "Test done." severity note;
    wait;
  end process;
end tb;

