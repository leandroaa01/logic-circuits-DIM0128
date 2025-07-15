library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity unidade_controle is
    Port (
        clk     : in  STD_LOGIC;
        reset   : in  STD_LOGIC;
        op      : in  STD_LOGIC; 
        estado  : out STD_LOGIC_VECTOR(1 downto 0)
    );
end unidade_controle;

architecture FSM of unidade_controle is
    -- Definição dos estados
    constant RESETAR  : STD_LOGIC_VECTOR(1 downto 0) := "00";
    constant OPERACAO : STD_LOGIC_VECTOR(1 downto 0) := "01";
    constant LER      : STD_LOGIC_VECTOR(1 downto 0) := "10";
    constant ESCREVER : STD_LOGIC_VECTOR(1 downto 0) := "11";
    
    signal estado_atual : STD_LOGIC_VECTOR(1 downto 0) := RESETAR;
begin
    process(clk, reset)
    begin
        if reset = '1' then
            estado_atual <= RESETAR;
        elsif ( clk'event and clk = '1')then
            case estado_atual is
                when RESETAR =>
                    estado_atual <= OPERACAO;
                    
                when OPERACAO =>
                    -- Decide operação baseado em 'op'
                    if op = '0' then
                        estado_atual <= LER;
                    else
                        estado_atual <= ESCREVER;
                    end if;
                    
                when LER | ESCREVER =>
                    -- Retorna para Operação após LERtura/escrita
                    estado_atual <= OPERACAO;
                    
                when others =>
                    estado_atual <= RESETAR;
            end case;
        end if;
    end process;
    
    estado <= estado_atual;
end FSM;