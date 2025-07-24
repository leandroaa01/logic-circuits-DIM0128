-- Importa as bibliotecas padrão do VHDL
LIBRARY ieee;
USE ieee.std_logic_1164.ALL; -- Para tipos de dados lógicos
USE ieee.numeric_std.ALL;    -- Para operações aritméticas com vetores

-- Declaração da entidade banco
-- Define as entradas e saídas do módulo
entity banco is 
    port(
        clk, r, op: in std_logic; -- Entradas: clock, reset e operação
        dado: in std_logic_vector(15 DOWNTO 0); -- Entrada de dados (16 bits)
        led_registrador: out std_logic_vector (2 DOWNTO 0); -- Saída para indicar o registrador selecionado
        s_dado: out std_logic_vector (15 DOWNTO 0); -- Saída de dados (16 bits)
        s_operacao, s_reset: out std_logic; -- Sinais de operação e reset
        s_maquina: out std_logic_vector(1 DOWNTO 0) -- Estado atual da FSM (2 bits)
    );
end entity banco;

-- Arquitetura do banco de registradores
architecture compomental of banco is 

    -- Define um banco de 8 registradores de 16 bits
    TYPE banco_reg IS ARRAY (0 TO 7) OF STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL registradores : banco_reg := (OTHERS => (OTHERS => '0')); -- Inicializa todos os registradores com 0

    -- Define os estados da máquina de estados finita (FSM)
    TYPE fsm IS (RESET, OPERACAO, LER, ESCREVER);
    SIGNAL estado_atual : fsm := RESET; -- Estado inicial é RESET

    -- Sinais internos para controle
    SIGNAL reg_endereco : STD_LOGIC_VECTOR(2 DOWNTO 0); -- Endereço do registrador (3 bits)
    SIGNAL reg_dado     : STD_LOGIC_VECTOR(15 DOWNTO 0); -- Dado a ser escrito
    SIGNAL reg_leitura  : STD_LOGIC_VECTOR(15 DOWNTO 0); -- Dado lido do registrador

BEGIN
    -- Processo principal sensível a clk, reset e op
    process(clk, r, op)
    begin 
	 s_operacao <= op; -- Atualiza a saída com o valor de op
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
		
            -- Máquina de estados finita (FSM)
            Case estado_atual is 

                -- Estado RESET
                when RESET =>
                    estado_atual <= OPERACAO; -- Transita para o estado OPERACAO
                    s_maquina <= "00"; -- Indica o estado RESET na saída
						  s_reset <= r;
                -- Estado OPERACAO
                when OPERACAO =>
					    if r = '1' then 
						 estado_atual <= RESET;
						 
                    elsif (op = '1') then
                        -- Operação de escrita
                        reg_dado <= dado; -- Armazena o dado de entrada
                        estado_atual <= ESCREVER; -- Transita para o estado ESCREVER
                    else
                        -- Operação de leitura
                        reg_endereco <= dado(15 DOWNTO 13); -- Extrai o endereço do registrador
                        estado_atual <= LER; -- Transita para o estado LER
                        led_registrador <= reg_endereco; -- Atualiza o LED com o endereço
                    end if;
						  s_reset <='0'; 
                    s_maquina <= "01"; -- Indica o estado OPERACAO na saída

                -- Estado LER
                when LER =>
                    reg_leitura <= registradores(to_integer(unsigned(reg_endereco))); -- Lê o dado do registrador
                    estado_atual <= OPERACAO; -- Transita para o estado OPERACAO
                    s_maquina <= "10"; -- Indica o estado LER na saída

                -- Estado ESCREVER
                when ESCREVER =>
                    registradores(to_integer(unsigned(reg_endereco))) <= reg_dado; -- Escreve o dado no registrador
                    estado_atual <= LER; -- Transita para o estado LER
                    s_maquina <= "11"; -- Indica o estado ESCREVER na saída

                -- Estado padrão (OTHERS)
                WHEN OTHERS =>
                    estado_atual <= RESET; -- Retorna ao estado RESET
            END CASE;
        END IF;
    END PROCESS;

    -- Atribui o dado lido à saída
    s_dado <= reg_leitura;
END ARCHITECTURE compomental;