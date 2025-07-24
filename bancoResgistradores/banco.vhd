-- Importa as bibliotecas padr�o do VHDL
LIBRARY ieee;
USE ieee.std_logic_1164.ALL; -- Para tipos de dados l�gicos
USE ieee.numeric_std.ALL;    -- Para opera��es aritm�ticas com vetores

-- Declara��o da entidade banco
-- Define as entradas e sa�das do m�dulo
entity banco is 
    port(
        clk, r, op: in std_logic; -- Entradas: clock, reset e opera��o
        dado: in std_logic_vector(15 DOWNTO 0); -- Entrada de dados (16 bits)
        led_registrador: out std_logic_vector (2 DOWNTO 0); -- Sa�da para indicar o registrador selecionado
        s_dado: out std_logic_vector (15 DOWNTO 0); -- Sa�da de dados (16 bits)
        s_operacao, s_reset: out std_logic; -- Sinais de opera��o e reset
        s_maquina: out std_logic_vector(1 DOWNTO 0) -- Estado atual da FSM (2 bits)
    );
end entity banco;

-- Arquitetura do banco de registradores
architecture compomental of banco is 

    -- Define um banco de 8 registradores de 16 bits
    TYPE banco_reg IS ARRAY (0 TO 7) OF STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL registradores : banco_reg := (OTHERS => (OTHERS => '0')); -- Inicializa todos os registradores com 0

    -- Define os estados da m�quina de estados finita (FSM)
    TYPE fsm IS (RESET, OPERACAO, LER, ESCREVER);
    SIGNAL estado_atual : fsm := RESET; -- Estado inicial � RESET

    -- Sinais internos para controle
    SIGNAL reg_endereco : STD_LOGIC_VECTOR(2 DOWNTO 0); -- Endere�o do registrador (3 bits)
    SIGNAL reg_dado     : STD_LOGIC_VECTOR(15 DOWNTO 0); -- Dado a ser escrito
    SIGNAL reg_leitura  : STD_LOGIC_VECTOR(15 DOWNTO 0); -- Dado lido do registrador

BEGIN
    -- Processo principal sens�vel a clk, reset e op
    process(clk, r, op)
    begin 
	 s_operacao <= op; -- Atualiza a sa�da com o valor de op
        -- Se o reset estiver ativo
        if r = '1' then
            -- Zera todos os registradores e sinais internos
            registradores <= (OTHERS => (OTHERS => '0'));
            reg_endereco <= (OTHERS => '0');
            reg_dado <= (OTHERS => '0');
				reg_leitura <=(OTHERS => '0');
            -- Define o estado atual como RESET
            estado_atual <= RESET;
				s_reset <= r;

        -- Evento de borda de subida do clock
        elsif (clk'event and clk = '1') then
		
            -- M�quina de estados finita (FSM)
            Case estado_atual is 

                -- Estado RESET
                when RESET =>
                    estado_atual <= OPERACAO; -- Transita para o estado OPERACAO
                    s_maquina <= "00"; -- Indica o estado RESET na sa�da
						  s_reset <= r;
                -- Estado OPERACAO
                when OPERACAO =>
					    if r = '1' then 
						 estado_atual <= RESET;
						 
                    elsif (op = '1') then
                        -- Opera��o de escrita
                        reg_dado <= dado; -- Armazena o dado de entrada
                        estado_atual <= ESCREVER; -- Transita para o estado ESCREVER
                    else
                        -- Opera��o de leitura
                        reg_endereco <= dado(15 DOWNTO 13); -- Extrai o endere�o do registrador
                        estado_atual <= LER; -- Transita para o estado LER
                        led_registrador <= reg_endereco; -- Atualiza o LED com o endere�o
                    end if;
						  s_reset <='0'; 
                    s_maquina <= "01"; -- Indica o estado OPERACAO na sa�da

                -- Estado LER
                when LER =>
                    reg_leitura <= registradores(to_integer(unsigned(reg_endereco))); -- L� o dado do registrador
                    estado_atual <= OPERACAO; -- Transita para o estado OPERACAO
                    s_maquina <= "10"; -- Indica o estado LER na sa�da

                -- Estado ESCREVER
                when ESCREVER =>
                    registradores(to_integer(unsigned(reg_endereco))) <= reg_dado; -- Escreve o dado no registrador
                    estado_atual <= LER; -- Transita para o estado LER
                    s_maquina <= "11"; -- Indica o estado ESCREVER na sa�da

                -- Estado padr�o (OTHERS)
                WHEN OTHERS =>
                    estado_atual <= RESET; -- Retorna ao estado RESET
            END CASE;
        END IF;
    END PROCESS;

    -- Atribui o dado lido � sa�da
    s_dado <= reg_leitura;
END ARCHITECTURE compomental;