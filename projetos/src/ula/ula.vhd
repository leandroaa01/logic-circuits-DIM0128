LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all; -- Para operações aritméticas

ENTITY ULA IS
PORT (
    A, B : IN STD_LOGIC_VECTOR(15 downto 0);
    M, S1, S0 : IN STD_LOGIC;
    F : OUT STD_LOGIC_VECTOR(15 downto 0)
);
END ULA;

ARCHITECTURE comportamental OF ULA IS
SIGNAL Seletor : STD_LOGIC_VECTOR(2 downto 0);
BEGIN
    Seletor <= M & S1 & S0; 

    PROCESS (A, B, Seletor) 
    BEGIN
        CASE Seletor IS
            WHEN "000" => F <= A + B;           -- Soma
            WHEN "001" => F <= A - B;           -- Subtração
            WHEN "010" => F <= A(14 downto 0) & '0'; -- Desloc. esquerda
            WHEN "011" => F <= '0' & A(15 downto 1); -- Desloc. direita
            WHEN "100" => F <= A and B;         -- AND
            WHEN "101" => F <= A or B;          -- OR
            WHEN "110" => F <= A xor B;         -- XOR
            WHEN "111" => F <= A xnor B;        -- XNOR
            WHEN OTHERS => F <= (OTHERS => '0'); -- Default
        END CASE;
    END PROCESS;
END comportamental;