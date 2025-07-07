library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CoffeeMachine is
    Port (
        code : in  STD_LOGIC_VECTOR(2 downto 0);  -- Código do botão (3 bits)
        coffee   : out STD_LOGIC_VECTOR(7 downto 0);  -- Saídas para cafés (A-H)
        led: out STD_LOGIC                      -- LED de seleção válida
    );
end CoffeeMachine;

architecture Comportamental of CoffeeMachine is
begin
    process(code)
    begin
        -- Valores padrão
        coffee <= (others => '0');
        led <= '1';  -- Assume que é válido por padrão
        
        case code is
            when "001" => coffee(0) <= '1';  -- A
            when "010" => coffee(1) <= '1';  -- B
            when "011" => coffee(2) <= '1';  -- C
            when "100" => coffee(3) <= '1';  -- D
            when "101" => coffee(4) <= '1';  -- E
            when "110" => coffee(5) <= '1';  -- F
            when "111" => coffee(6) <= '1';  -- G
            when "000" => coffee(7) <= '1';  -- H
            when others => 
            led <= '0';  -- Invalida apenas quando não reconhece
        end case;
    end process;
end Comportamental;