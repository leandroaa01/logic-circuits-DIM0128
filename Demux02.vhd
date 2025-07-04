library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

Entity Demux02 is 
	Port(
			E, SEL : IN STD_LOGIC_VECTOR( 0 TO 1);
			A, B, C, D : OUT STD_LOGIC_VECTOR( 0 TO 1)
	    );
End Demux02;

architecture data02 of Demux02 is
begin
	 with SEL select
        A <= E when "00",
                "00"   when others;
                
    with sel select
        B <= E when "01",
                "00"   when others;
                
    with sel select
        C <= E when "10",
                "00"   when others;
                
    with sel select
        D <= E when "11",
                "00"   when others;
    
end data02;