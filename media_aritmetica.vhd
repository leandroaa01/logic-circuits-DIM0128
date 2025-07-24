library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Entidade principal do sistema de média aritmética
entity media_aritmetica is
    Port (
        clk            : in  STD_LOGIC;         -- Sinal de clock do sistema
        reset          : in  STD_LOGIC;         -- Sinal de reset (ativo alto)
		  ok             : in  STD_LOGIC;         -- Sinal para fazer o calculo
        entrada_Y      : in  STD_LOGIC_VECTOR(15 downto 0);  -- Valor Y de entrada via chaves
        led_resultado  : out STD_LOGIC  ;         -- LED que indica resultado pronto
		  s_reset        : out STD_LOGIC  ;         -- LED reset
		  saida_Y        : out  STD_LOGIC_VECTOR(15 downto 0) 
    );
end media_aritmetica;

architecture comportamental of media_aritmetica is
    -- Constante X: valor fixo para o cálculo )
    constant VALOR_X : std_logic_vector(15 downto 0) := "0010011011010111"; --9943
    
    -- Definição dos estados da máquina de estados finitas (FSM)
    type tipo_estado is (
        REINICIAR,        -- Estado inicial/reset
        LER_ENTRADA,      -- Estado de leitura do valor Y
        CALCULAR_MEDIA,   -- Estado de cálculo da média
        EXIBIR_RESULTADO  -- Estado final (resultado pronto)
    );
    
    signal estado : tipo_estado := REINICIAR;  -- Registrador de estado atual
    
    -- Sinais para armazenamento de valores
    signal registro_Y : std_logic_vector(15 downto 0) := (others => '0');      -- Registra o valor Y
    signal registro_media : std_logic_vector(15 downto 0) := (others => '0');  -- Armazena o resultado
    
begin
 

    -- Processo principal: Máquina de estados finitas (FSM)
    process(clk, reset)
    begin
       
            
        if (clk'event and clk = '1') then
		  saida_Y <= VALOR_X; -- MOSTRAR O VALOR DE X
		  s_reset <= '0';
		  led_resultado <= '0';  -- LED apagado
            -- Lógica de transição de estados
            case estado is
                when REINICIAR =>
                    if reset = '1' then
                     -- Reset do sistema
                       estado <= REINICIAR;
                      registro_Y <= (others => '0');
                      registro_media <= (others => '0');
                      led_resultado <= '0';  -- LED apagado
				          s_reset <= reset;
						    registro_media <= (others => '0');
							 else
                      estado <= LER_ENTRADA;  -- Transição para próximo estado
							 end if;
                    
                when LER_ENTRADA =>
					   if (reset ='1') then
						   estado <= REINICIAR;
                     elsif (ok ='1') then
                        registro_Y <= entrada_Y;
								saida_Y <= entrada_Y;
                        estado <= CALCULAR_MEDIA;  -- Avança para cálculo
							else
							estado <= LER_ENTRADA;  -- fica no mesmo estado
							saida_Y <= (others => '0');
                    end if;
						  
                when CALCULAR_MEDIA =>
                    -- Estado de cálculo da média
                    -- Média = (X + Y)/2 (implementado com deslocamento)
                    registro_media <= std_logic_vector(
                        shift_right(unsigned(VALOR_X) + unsigned(registro_Y), 1));
                    estado <= EXIBIR_RESULTADO;  -- Avança para estado final
                    
                when EXIBIR_RESULTADO =>
                    -- Estado final: resultado pronto
                    led_resultado <= '1';  -- Acende LED indicador
                    saida_Y <= registro_media;  
						  estado <= LER_ENTRADA;  --volta para o inico
            end case;
        end if;
    end process;
end comportamental;