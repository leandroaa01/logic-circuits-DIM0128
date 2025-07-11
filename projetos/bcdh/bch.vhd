library IEEE; -- Biblioteca padrão do VHDL
use IEEE.STD_LOGIC_1164.ALL; -- Biblioteca para tipos lógicos

ENTITY bch IS -- Entidade do BCD(h) para 7 segmentos
	PORT (
		Code : IN std_logic_vector(3 DOWNTO 0);
		S :OUT std_logic_vector(6 DOWNTO 0)
	);
END ENTITY bch;

ARCHITECTURE Comportamental OF bch IS
BEGIN
    PROCESS(Code)
    BEGIN
        CASE Code IS
            WHEN "0000" => S <= "1111110"; -- 0
            WHEN "0001" => S <= "0110000"; -- 1
            WHEN "0010" => S <= "1101101"; -- 2
            WHEN "0011" => S <= "1111001"; -- 3
            WHEN "0100" => S <= "0110011"; -- 4
            WHEN "0101" => S <= "1011011"; -- 5
            WHEN "0110" => S <= "1011111"; -- 6
            WHEN "0111" => S <= "1110000"; -- 7
            WHEN "1000" => S <= "1111111"; -- 8
            WHEN "1001" => S <= "1111011"; -- 9
            WHEN "1010" => S <= "1110111"; -- A
            WHEN "1011" => S <= "0011111"; -- B
            WHEN "1100" => S <= "1001110"; -- C
            WHEN "1101" => S <= "0111101"; -- D
            WHEN "1110" => S <= "1001111"; -- E
            WHEN "1111" => S <= "1000111"; -- F
        END CASE;
    END PROCESS;
END ARCHITECTURE Comportamental;