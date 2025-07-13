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
        we        : in  STD_LOGIC;   -- Write Enable
        led_reg   : out STD_LOGIC_VECTOR(2 downto 0);
        dado_sai  : out STD_LOGIC_VECTOR(15 downto 0)
    );
end caminho_dados;

architecture Operativo of caminho_dados is
    constant RESETAR  : STD_LOGIC_VECTOR(1 downto 0) := "00";
    constant AGUARDAR : STD_LOGIC_VECTOR(1 downto 0) := "01";
    constant OPERAR   : STD_LOGIC_VECTOR(1 downto 0) := "10";
    
    type banco_t is array (0 to 7) of STD_LOGIC_VECTOR(15 downto 0);
    signal registradores : banco_t;
    
    signal endereco_reg : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
begin
    -- Atualização assíncrona dos LEDs
    led_reg <= end_reg;
    
    -- Processo principal síncrono
    process(clk, reset)
    begin
        if reset = '1' then
            -- Reset do banco de registradores
            registradores <= (others => (others => '0'));
            dado_sai <= (others => '0');
            endereco_reg <= (others => '0');
            
        elsif rising_edge(clk) then
            -- Captura endereço no estado AGUARDAR
            if estado = AGUARDAR then
                endereco_reg <= end_reg;
            end if;
            
            -- Operação no estado OPERAR
            if estado = OPERAR then
                if we = '1' then
                    -- Operação de escrita
                    registradores(to_integer(unsigned(endereco_reg))) <= dado_ent;
                    dado_sai <= dado_ent;  -- Eco da escrita
                else
                    -- Operação de leitura
                    dado_sai <= registradores(to_integer(unsigned(endereco_reg)));
                end if;
            end if;
        end if;
    end process;
end Operativo;