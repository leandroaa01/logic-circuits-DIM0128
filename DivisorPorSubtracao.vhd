library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DivisorPorSubtracao is
    Port (
        clock     : in  STD_LOGIC;
        reset     : in  STD_LOGIC;
        entrada   : in  STD_LOGIC_VECTOR(15 downto 0);
        seletor   : in  STD_LOGIC_VECTOR(1 downto 0);
        carregar  : in  STD_LOGIC;
        quociente : out STD_LOGIC_VECTOR(15 downto 0);
        resto     : out STD_LOGIC_VECTOR(15 downto 0);
        erro      : out STD_LOGIC;
        pronto    : out STD_LOGIC
    );
end DivisorPorSubtracao;

architecture Comportamento of DivisorPorSubtracao is
    type estado_t is (
        CARREGANDO_A,
        CARREGANDO_B,
        INICIO,
        DIVIDINDO,
        RESULTADO
    );
    
    signal estado : estado_t;
    signal reg_A : UNSIGNED(15 downto 0);
    signal reg_B : UNSIGNED(15 downto 0);
    signal contador : UNSIGNED(15 downto 0);
begin
    process(clock, reset)
    begin
        if reset = '1' then
            estado <= CARREGANDO_A;
            reg_A <= (others => '0');
            reg_B <= (others => '0');
            contador <= (others => '0');
            quociente <= (others => '0');
            resto <= (others => '0');
            erro <= '0';
            pronto <= '0';
            
        elsif rising_edge(clock) then
            -- Reset interno de sinais temporários
            erro <= '0';
            pronto <= '0';
            
            case estado is
                when CARREGANDO_A =>
                    if carregar = '1' and seletor = "00" then
                        reg_A <= UNSIGNED(entrada);
                        estado <= CARREGANDO_B;
                    end if;
                
                when CARREGANDO_B =>
                    if carregar = '1' and seletor = "01" then
                        reg_B <= UNSIGNED(entrada);
                        
                        -- Verifica erros
                        if reg_B = 0 then
                            erro <= '1';
                        elsif reg_B > reg_A then
                            erro <= '1';
                        else
                            contador <= (others => '0');
                            estado <= INICIO;
                        end if;
                    end if;
                
                when INICIO =>
                    if reg_A >= reg_B then
                        estado <= DIVIDINDO;
                    else
                        resto <= STD_LOGIC_VECTOR(reg_A);
                        quociente <= STD_LOGIC_VECTOR(contador);
                        pronto <= '1';
                        estado <= RESULTADO;
                    end if;
                
                when DIVIDINDO =>
                    reg_A <= reg_A - reg_B;
                    contador <= contador + 1;
                    estado <= INICIO;
                
                when RESULTADO =>
                    pronto <= '1';
                    estado <= CARREGANDO_A;  -- Volta para início automático
            end case;
        end if;
    end process;
end Comportamento;