--Projeto: Demultiplexor 1 para 4 bits
--Descrição: Implementação de um demultiplexor 1 para 4 bits
--Autor: [Leandro Andrade]
library IEEE; -- Biblioteca padrão do VHDL
use IEEE.STD_LOGIC_1164.ALL; -- Biblioteca para tipos lógicos

Entity Demux02 is  -- Entidade do demultiplexor 1 para 4 bits
	Port(
                E, SEL : IN STD_LOGIC_VECTOR( 0 TO 1); -- Entrada de 2 bits
                A, B, C, D : OUT STD_LOGIC_VECTOR( 0 TO 1) -- Saídas de 2 bits
	    );
End Demux02;

architecture data02 of Demux02 is -- Arquitetura de Fluxo de dados do demultiplexor 1 para 4 bits
begin
	 with SEL select
        A <= E when "00", -- Saída A ativa quando S = "00"
                "00"   when others; 
                
    with sel select
        B <= E when "01", -- Saída B ativa quando S = "01"
                "00"   when others;
                
    with sel select
        C <= E when "10", -- Saída C ativa quando S = "10"
                "00"   when others;
                
    with sel select
        D <= E when "11", -- Saída D ativa quando S = "11"
                "00"   when others;
    
end data02;