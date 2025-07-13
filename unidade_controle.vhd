library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity unidade_controle is
    Port (
        clk     : in  STD_LOGIC;
        reset   : in  STD_LOGIC;
        estado  : out STD_LOGIC_VECTOR(1 downto 0)
    );
end unidade_controle;

architecture FSM of unidade_controle is
    constant RESETAR  : STD_LOGIC_VECTOR(1 downto 0) := "00";
    constant AGUARDAR : STD_LOGIC_VECTOR(1 downto 0) := "01";
    constant OPERAR   : STD_LOGIC_VECTOR(1 downto 0) := "10";
    
    signal estado_atual : STD_LOGIC_VECTOR(1 downto 0) := RESETAR;
begin
    process(clk, reset)
    begin
        if reset = '1' then
            estado_atual <= RESETAR;
        elsif rising_edge(clk) then
            case estado_atual is
                when RESETAR =>
                    estado_atual <= AGUARDAR;
                    
                when AGUARDAR =>
                    estado_atual <= OPERAR;
                    
                when OPERAR =>
                    estado_atual <= AGUARDAR;
                    
                when others =>
                    estado_atual <= RESETAR;
            end case;
        end if;
    end process;
    
    estado <= estado_atual;
end FSM;