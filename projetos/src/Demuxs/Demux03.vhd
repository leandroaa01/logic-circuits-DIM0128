library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

Entity Demux03 is 
	Port(
			E, SEL : IN STD_LOGIC_VECTOR( 0 TO 1);
			A, B, C, D : OUT STD_LOGIC_VECTOR( 0 TO 1)
	    );
End Demux03;

architecture data03 of Demux03 is
begin
	 process(E, SEL)
    begin
        A <= "00";
        B <= "00";
        C <= "00";
        D <= "00";
        
        if SEL = "00" then
            A <= E;
        elsif SEL = "01" then
            B <= E;
        elsif SEL = "10" then
            C <= E;
        elsif SEL = "11" then
            D <= E;
        end if;
    end process;
    
end data03;