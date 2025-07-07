library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

Entity Demux01 is 
	Port(
			F, S : IN STD_LOGIC_VECTOR( 0 TO 1);
			A, B, C, D : OUT STD_LOGIC_VECTOR( 0 TO 1)
	    );
End Demux01;

architecture data01 of Demux01 is
begin
    A <= F when S = "00" else "00";
    B <= F when S = "01" else "00";
    C <= F when S = "10" else "00";
    D <= F when S = "11" else "00";
end data01;
