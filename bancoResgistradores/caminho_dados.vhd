library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity caminho_dados is
    Port (
        clk       : in  STD_LOGIC;
        reset     : in  STD_LOGIC;
        estado    : in  STD_LOGIC_VECTOR(1 downto 0);
        end_reg   : in  STD_LOGIC_VECTOR(2 downto 0);
        dado_ent  : in  STD_LOGIC_VECTOR(15 downto 0);
        led_reg   : out STD_LOGIC_VECTOR(2 downto 0);
        dado_sai  : out STD_LOGIC_VECTOR(15 downto 0)
    );
end caminho_dados;

architecture Operativo of caminho_dados is
    -- Definição dos estados
    constant RESETAR  : STD_LOGIC_VECTOR(1 downto 0) := "00";
    constant OPERACAO : STD_LOGIC_VECTOR(1 downto 0) := "01";
    constant LER      : STD_LOGIC_VECTOR(1 downto 0) := "10";
    constant ESCREVER : STD_LOGIC_VECTOR(1 downto 0) := "11";
    
    type banco_t is array (0 to 7) of STD_LOGIC_VECTOR(15 downto 0);
    signal registradores : banco_t;
    
    signal endereco_reg : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
begin
    process(clk, reset)
    begin
        if reset = '1' then
            -- Reset síncrono
            registradores <= (others => (others => '0'));
            dado_sai <= (others => '0');
            led_reg <= (others => '0');
            endereco_reg <= (others => '0');
            
        elsif( clk'event and clk = '1') then
            case estado is
                when RESETAR =>
                    -- Estado de reset (zerar tudo)
                    registradores <= (others => (others => '0'));
                    dado_sai <= (others => '0');
                    led_reg <= (others => '0');
                    endereco_reg <= (others => '0');
                    
                when OPERACAO =>
                    -- Captura endereço do registrador
                    endereco_reg <= end_reg;
                    
                when LER =>
                    -- Operação de LERtura
                    dado_sai <= registradores(to_integer(unsigned(endereco_reg)));
                    led_reg <= endereco_reg;  -- Mostra endereço lido
                    
                when ESCREVER =>
                    -- Operação de escrita
                    registradores(to_integer(unsigned(endereco_reg))) <= dado_ent;
                    dado_sai <= dado_ent;    -- Eco do dado escrito
                    led_reg <= endereco_reg;  -- Mostra endereço escrito
                    
                when others =>
                    null; -- Estados não utilizados
            end case;
        end if;
    end process;
end Operativo;