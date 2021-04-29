library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package meu_pack is

constant WSIZE : natural := 8;
constant ZERO_K : std_logic_vector(WSIZE-1 downto 0) := (others => '0');
end meu_pack;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.meu_pack.all;
  
entity ulaRV is
	generic(WSIZE: natural := 32);
	port (
		opcode: 	in  std_logic_vector(3 downto 0);
		A, B:		in  std_logic_vector(WSIZE-1 downto 0);
		Z:			out std_logic_vector(WSIZE-1 downto 0);
		zero:		out std_logic);
end ulaRV;

architecture arch of ulaRV is

signal   aux : std_logic_vector(WSIZE-1 downto 0);

begin
	
	Z <= aux;
	zero <= '1' when (to_integer(unsigned(aux)) = to_integer(unsigned(ZERO_K))) else '0';
	
ulaRV: process (A, B, opcode) 
	begin
      case opcode is
		when "0000" => aux <= std_logic_vector(signed(A) + signed(B));
		when "0001" => aux <= std_logic_vector(signed(A) - signed(B));
		when "0010" => aux <= (A and B);
		when "0011"  => aux <= (A or B);
        	when "0100" => aux <= (A xor B);
        	when "0101" => aux <= std_logic_vector(shift_left(unsigned(A),to_integer(unsigned(B))));
        	when "0110" => aux <= std_logic_vector(shift_right(unsigned(A),to_integer(unsigned(B))));
        	when "0111" => aux <= std_logic_vector(shift_right(signed(A),to_integer(unsigned(B))));
        	when "1000" => aux <= x"00000001" when (signed(A) < signed(B)) else x"00000000";
        	when "1001"=> aux <= x"00000001" when (unsigned(A) < unsigned(B)) else x"00000000";
        	when "1010" => aux <= x"00000001" when (signed(A) >= signed(B)) else x"00000000";
        	when "1011"=> aux <= x"00000001" when (unsigned(A) >= unsigned(B)) else x"00000000";
        	when "1100" => aux <= x"00000001" when (A = B) else x"00000000";
        	when "1101" => aux <= x"00000001" when (A /= B) else x"00000000";
        	when others  => aux <= std_logic_vector(resize(signed(ZERO_K), 32));
      end case;
    end process;
end arch;