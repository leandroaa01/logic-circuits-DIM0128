--Projeto: Demultiplexor 1 para 4 bits
--Descrição: Implementação de um demultiplexor 1 para 4 bits
--Autor: [Leandro Andrade]
library IEEE; -- Biblioteca padrão do VHDL
use IEEE.STD_LOGIC_1164.ALL; -- Biblioteca para tipos lógicos

Entity Demux04 is  -- Demultiplexor 1 para 4 bits
   
	Port(
        E, SEL : IN STD_LOGIC_VECTOR( 0 TO 1); -- Entrada de 2 bits
        A, B, C, D : OUT STD_LOGIC_VECTOR( 0 TO 1) -- Saídas de 2 bits
	    );
End Demux04;

architecture data04 of Demux04 is -- Arquitetura do Demultiplexor 1 para 4 bits
begin
	 process(E, SEL)
    begin
        -- Inicializa as saídas
        A <= "00";
        B <= "00";
        C <= "00";
        D <= "00";
     case SEL is
            when "00"   => A <= E; -- Saída A ativa quando SEL = "00"
            when "01"   => B <= E; -- Saída B ativa quando SEL = "01"
            when "10"   => C <= E; -- Saída C ativa quando SEL = "10"
            when "11"   => D <= E; -- Saída D ativa quando SEL = "11"
            when others => NULL;  
        end case;
    end process;
    
end data04;