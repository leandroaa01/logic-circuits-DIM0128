library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DivisorPorSubtracao is
    Port (
        clk       : in  STD_LOGIC;                       -- Sinal de clock.
        reset     : in  STD_LOGIC;                     -- Sinal de reset ass�ncrono.
        entrada   : in  STD_LOGIC_VECTOR(15 downto 0); -- Entrada de 16 bits (valor a carregar).
        seletor   : in  STD_LOGIC_VECTOR(1 downto 0);  -- Seletor para decidir se a entrada vai para A ou B.
        carregar  : in  STD_LOGIC;                     -- Sinal para acionar o carregamento.
        quociente : out STD_LOGIC_VECTOR(15 downto 0); -- Sa�da do quociente (resultado da divis�o).
        resto     : out STD_LOGIC_VECTOR(15 downto 0); -- Sa�da do resto da divis�o.
        erro      : out STD_LOGIC;                     -- Sinal de erro (ex: divis�o por zero ou B > A).
        pronto    : out STD_LOGIC;                     -- Sinal que indica fim do processo.
		  s_reset   : out STD_LOGIC;                     -- saida da o reset
		  s_maquina :  out std_logic_vector(1 DOWNTO 0) -- Estado atual da FSM (2 bits)
    );
end DivisorPorSubtracao;

architecture Comportamento of DivisorPorSubtracao is  
-- Define a arquitetura do componente.

    type estado_t is (
        CARREGANDO,   -- Estado para carregar o valor de A OU B.
        INICIO,         -- Estado de verifica��o se pode iniciar a subtra��o.
        DIVIDINDO,      -- Estado onde ocorre a subtra��o.
        RESULTADO       -- Estado final onde os resultados s�o emitidos.
    );
    
    signal estado : estado_t;                          -- Sinal de controle de estado (FSM).
    signal reg_A : UNSIGNED(15 downto 0);              -- Registrador A, armazena o dividendo.
    signal reg_B : UNSIGNED(15 downto 0);              -- Registrador B, armazena o divisor.
    signal contador : UNSIGNED(15 downto 0);           -- Contador de subtra��es (ser� o quociente).
begin

    process(clk, reset)
    -- Processo sens�vel ao clock e ao reset.
    begin
       	 if reset = '1' then
							-- Se o reset for ativado, inicializa todos os sinais.
							estado <= CARREGANDO;
							reg_A <= (others => '0');
							reg_B <= (others => '0');
							contador <= (others => '0');
							quociente <= (others => '0');
							resto <= (others => '0');
							erro <= '0';
							pronto <= '0';
							s_reset <= reset;
        elsif (clk'event and clk = '1') then
            
            -- Limpa sinais tempor�rios a cada ciclo.
            erro <= '0';
            pronto <= '0';
            
            case estado is
                -- M�quina de estados finitos (FSM)

                when CARREGANDO =>
					 s_reset <='0';
					 s_maquina <= "00";
                    -- Estado para carregar A.
                    if carregar = '1' and seletor = "00" then
                        reg_A <= UNSIGNED(entrada);         --  armazena o valor de A.
                        quociente <= entrada;               -- mostrar o valor de A 
							elsif carregar = '1' and seletor = "01" then
							
								if UNSIGNED(entrada) = 0 then                -- Divis�o por zero
								erro <= '1';
								elsif UNSIGNED(entrada) > reg_A then          --Divisor maior que dividendo.
								erro <= '1';
								else
							   reg_B <= UNSIGNED(entrada);         --  armazena o valor de B.
                        quociente <= entrada;           -- Mostrar o valor de B
                        contador <= (others => '0');    -- Zera o contador.
                        estado <= INICIO;               -- Avan�a para estado inicial de c�lculo.
                        end if;
								 
                    end if;
            
                
                when INICIO =>
							s_maquina <= "01";
						
                    -- Verifica se A ainda pode ser subtra�do por B.
                    if  reg_A >= reg_B then
                        estado <= DIVIDINDO;                -- Ainda pode dividir, vai para pr�ximo estado.
                    else
                        estado <= RESULTADO;                -- Vai para estado final.
                    end if;
                
                when DIVIDINDO =>
						s_maquina <= "10";
                    -- Realiza uma subtra��o (A := A - B) e incrementa o contador.
                    reg_A <= reg_A - reg_B;
                    contador <= contador + 1;
                    estado <= INICIO;                       -- Volta para verificar se pode continuar dividindo.
                
                when RESULTADO =>
						  s_maquina <= "11";
							-- A < B, n�o pode dividir mais, finaliza opera��o.
						  resto <= STD_LOGIC_VECTOR(reg_A);   -- Resto recebe valor atual de A.
                    quociente <= STD_LOGIC_VECTOR(contador); -- Converte contador (quociente) para sa�da.
                    pronto <= '1';                      -- Sinaliza fim.
                    estado <= CARREGANDO;                 -- Reinicia FSM para nova opera��o.
            end case;
        end if;
    end process;
end Comportamento;