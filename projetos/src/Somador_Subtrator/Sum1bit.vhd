-- Projeto: Somador/Subtrator de 1 bits
-- Descrição: Implementação de um somador/subtrator de 1 bits
-- Autor: [Leandro Andrade]
library IEEE; -- Biblioteca padrão do VHDL
use IEEE.STD_LOGIC_1164.ALL; -- Biblioteca para tipos lógicos

entity Sum1bit is -- Entidade do somador/subtrator de 1 bit
    Port (
        A, B, Cin    : in  STD_LOGIC; -- Entradas de 1 bit
 S, Cout : out STD_LOGIC -- Saída de 1 bit
    );
end Sum1bit;
-- Arquitetura de fluxo de dados do somador/subtrator de 1 bit
architecture Dataflow of Sum1bit is 
begin
    S    <= A xor B xor Cin; -- Soma dos bits A, B e Cin
    Cout <= ((A XOR B) AND Cin) OR (A AND B); -- Carry-out da soma
end Dataflow;

