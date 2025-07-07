--Projeto: Máquina de Café
--Descrição: Implementação de uma máquina de café com 8 opções
-- Máquina de Café com 8 opções (A-H) e LED de seleção válida
--Autor: [Leandro Andrade]
library IEEE; -- Biblioteca padrão do VHDL
use IEEE.STD_LOGIC_1164.ALL; -- Biblioteca para tipos lógicos

entity CoffeeMachine is -- Entidade da Máquina de Café
    Port (
        code : in  STD_LOGIC_VECTOR(2 downto 0);  -- Código do botão (3 bits)
        coffee   : out STD_LOGIC_VECTOR(7 downto 0);  -- Saídas para cafés (A-H)
        led: out STD_LOGIC                      -- LED de seleção válida
    );
end CoffeeMachine;

architecture Comportamental of CoffeeMachine is -- Arquitetura Comportamental da Máquina de Café
begin
    process(code)
    begin
        -- Valores padrão
        coffee <= (others => '0');
        led <= '1';  -- Assume que é válido por padrão
        
        case code is
            when "001" => coffee(0) <= '1';  -- saída  de café A
            when "010" => coffee(1) <= '1';  -- saída  de café B
            when "011" => coffee(2) <= '1';  -- saída  de café C
            when "100" => coffee(3) <= '1';  -- saída  de café D
            when "101" => coffee(4) <= '1';  -- saída  de café E
            when "110" => coffee(5) <= '1';  -- saída  de café F
            when "111" => coffee(6) <= '1';  -- saída  de café G
            when "000" => coffee(7) <= '1';  -- saída  de café H
            when others => 
            led <= '0';  -- Invalida apenas quando não reconhece
        end case;
    end process;
end Comportamental;