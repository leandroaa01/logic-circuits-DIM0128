--Projeto: Demultiplexor 1 para 4 bits
--Descrição: Implementação de um demultiplexor 1 para 4 bits
--Autor: [Leandro Andrade]
library IEEE; -- Biblioteca padrão do VHDL
use IEEE.STD_LOGIC_1164.ALL; -- Biblioteca para tipos lógicos

Entity Demux03 is  -- Entidade do demultiplexor 1 para 4 bits
	Port(
        E, SEL : IN STD_LOGIC_VECTOR( 0 TO 1); -- Entrada de 2 bits
        A, B, C, D : OUT STD_LOGIC_VECTOR( 0 TO 1) -- Saídas de 2 bits
	    );
End Demux03;

architecture data03 of Demux03 is -- Arquitetura do demultiplexor 1 para 4 bits
begin
	 process(E, SEL)
    begin
        -- Inicializa as saídas
        A <= "00";
        B <= "00";
        C <= "00";
        D <= "00";
        
        if SEL = "00" then -- Saída A ativa quando S = "00"
            A <= E;
        elsif SEL = "01" then
            B <= E; -- Saída B ativa quando S = "01"
        elsif SEL = "10" then
            C <= E; -- Saída C ativa quando S = "10"
        elsif SEL = "11" then
            D <= E; -- Saída D ativa quando S = "11"
        end if;
    end process;
    
end data03;