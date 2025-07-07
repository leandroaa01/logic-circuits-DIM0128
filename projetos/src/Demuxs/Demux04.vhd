library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

Entity Demux04 is 
	Port(
			E, SEL : IN STD_LOGIC_VECTOR( 0 TO 1);
			A, B, C, D : OUT STD_LOGIC_VECTOR( 0 TO 1)
	    );
End Demux04;

architecture data04 of Demux04 is
begin
	 process(E, SEL)
    begin
        A <= "00";
        B <= "00";
        C <= "00";
        D <= "00";
     case SEL is
            when "00"   => A <= E;
            when "01"   => B <= E;
            when "10"   => C <= E;
            when "11"   => D <= E;
            when others => NULL;  
        end case;
    end process;
    
end data04;