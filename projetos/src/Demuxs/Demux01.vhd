--Projeto: Demultiplexor 1 para 4 bits
--Descrição: Implementação de um demultiplexor 1 para 4 bits
--Autor: [Leandro Andrade]
library IEEE; -- Biblioteca padrão do VHDL
use IEEE.STD_LOGIC_1164.ALL; -- Biblioteca para tipos lógicos

Entity Demux01 is  -- Entidade do demultiplexor 1 para 4 bits
	Port(
			E, SEL : IN STD_LOGIC_VECTOR( 0 TO 1); -- Entrada de 2 bits
			A, B, C, D : OUT STD_LOGIC_VECTOR( 0 TO 1); -- Saídas de 2 bits
         LED : OUT STD_LOGIC_VECTOR( 0 TO 3) -- LED de saída de 4 bits
	    );
End Demux01;

architecture data01 OF Demux01 is -- Arquitetura de Fluxo de dados do demultiplexor 1 para 4 bits
begin
    A <= E when SEL = "00" else "00"; -- Saída A ativa quando S = "00"
    B <= E when SEL = "01" else "00"; -- Saída B ativa quando S = "01"
    C <= E when SEL = "10" else "00"; -- Saída C ativa quando S = "10"
    D <= E when SEL = "11" else "00"; -- Saída D ativa quando S = "11"
    LED <= "1000" when SEL = "00"
	  else  "0100" when SEL = "01" 
	  else  "0010" when SEL = "10"  
	  else  "0001" When SEL = "11"; -- LED acende de acordo com a seleção
end data01;
