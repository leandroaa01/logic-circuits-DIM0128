-- Projeto: Somador/Subtrator de 8 bits
-- Descrição: Implementação de um somador/subtrator de 8 bits
-- Autor: [Leandro Andrade]
library IEEE; -- Biblioteca padrão do VHDL
use IEEE.STD_LOGIC_1164.ALL; -- Biblioteca para tipos lógicos

entity Sum is -- Entidade do somador/subtrator
    Port (
        A, B      : in  STD_LOGIC_VECTOR (7 downto 0); -- Entradas de 8 bits
        Cin       : in  STD_LOGIC;  -- 0 = Soma, 1 = Subtração
        S         : out STD_LOGIC_VECTOR (7 downto 0); -- Saída de 8 bits
        Cout      : out STD_LOGIC;  -- Carry-out final
        Overflow  : out STD_LOGIC   -- Overflow (apenas para números com sinal)
    );
end Sum;
architecture Etrutural of Sum is -- Arquitetura estrutural do somador/subtrator
    -- Declaração do componente Sum1bit, que representa um somador de 1 bit
    component Sum1bit
        Port (
            A, B, Cin : in  STD_LOGIC;
            S, Cout   : out STD_LOGIC
        );
    end component;
    -- Sinais internos para conectar os somadores de 1 bit
    signal C : STD_LOGIC_VECTOR(8 downto 0); -- Vetor de carry (9 bits, pois o carry final pode ser 1)
    signal B_mod : STD_LOGIC_VECTOR(7 downto 0);  -- Vetor modificado de B para subtração

begin
    -- Inverte B quando Cin='1' (subtração)
    B_mod <= B when Cin = '0' else NOT B;

    C(0) <= Cin;
    
    U0: Sum1bit port map(A(0), B_mod(0), C(0), S(0), C(1)); 
    U1: Sum1bit port map(A(1), B_mod(1), C(1), S(1), C(2));
    U2: Sum1bit port map(A(2), B_mod(2), C(2), S(2), C(3));
    U3: Sum1bit port map(A(3), B_mod(3), C(3), S(3), C(4));
    U4: Sum1bit port map(A(4), B_mod(4), C(4), S(4), C(5));
    U5: Sum1bit port map(A(5), B_mod(5), C(5), S(5), C(6));
    U6: Sum1bit port map(A(6), B_mod(6), C(6), S(6), C(7));
    U7: Sum1bit port map(A(7), B_mod(7), C(7), S(7), C(8));

    Cout <= C(8);
    Overflow <= C(7) xor C(8); -- Detecta overflow para números com sinal
end Etrutura;