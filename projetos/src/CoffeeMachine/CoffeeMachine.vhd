--Projeto: Máquina de Café
--Descrição: Implementação de uma máquina de café com 8 opções
-- Máquina de Café com 8 opções (A-H) e LED de seleção válida
--Autor: [Leandro Andrade]
library IEEE; -- Biblioteca padrão do VHDL
use IEEE.STD_LOGIC_1164.ALL; -- Biblioteca para tipos lógicos

entity CoffeeMachine is -- Entidade da Máquina de Café
    Port (
        A,B,C,D,E,F,G,H: in STD_LOGIC; -- Entradas de seleção (A-H)
        coffee   : out STD_LOGIC_VECTOR(2 downto 0);  -- Saídas para o code do café (0-7)
        led: out STD_LOGIC_VECTOR(7 downto 0)                      -- LED de seleção válida
    );
end CoffeeMachine;

architecture Comportamental of CoffeeMachine is -- Arquitetura Comportamental da Máquina de Café
begin
    process(A,B,C,D,E,F,G,H)
    begin
        -- Inicializa as saídas
        coffee <= "000"; -- Nenhum café selecionado
        led <= "00000000"; -- Nenhum LED aceso
		  if H = '1' then
            coffee <= "000"; -- Café H selecionado
            led(0) <= '1'; -- LED H aceso
        elsif  A = '1' then
            coffee <= "001"; -- Café A selecionado
            led(1) <= '1'; -- LED A aceso
        elsif B = '1' then
            coffee <= "010"; -- Café B selecionado
            led(2) <= '1'; -- LED B aceso
        elsif C = '1' then
            coffee <= "011"; -- Café C selecionado
            led(3) <= '1'; -- LED C aceso
        elsif D = '1' then
            coffee <= "100"; -- Café D selecionado
            led(4) <= '1'; -- LED D aceso
        elsif E = '1' then
            coffee <= "101"; -- Café E selecionado
            led(5) <= '1'; -- LED E aceso
        elsif F = '1' then
            coffee <= "110"; -- Café F selecionado
            led(6) <= '1'; -- LED F aceso
        elsif G = '1' then
            coffee <= "111"; -- Café G selecionado
            led(7) <= '1'; -- LED G aceso
		  end if;
    end process;
end Comportamental;