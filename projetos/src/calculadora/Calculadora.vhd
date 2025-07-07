-- Projeto: Calculadora Simples
-- Descrição: Implementação de uma calculadora simples que realiza soma e subtração
-- com entradas de 8 bits e acende luzes indicadoras para cada operação.
-- Autor: [Leandro Andrade]
library IEEE; -- Biblioteca padrão do VHDL
use IEEE.STD_LOGIC_1164.ALL; -- Biblioteca para tipos lógicos
use IEEE.STD_LOGIC_ARITH.ALL;  -- Biblioteca ARITH para operações aritméticas
use IEEE.STD_LOGIC_UNSIGNED.ALL; -- Biblioteca UNSIGNED para operações com vetores lógicos

entity Calculadora is -- Definição da entidade Calculadora
    Port (
        A, B : in  STD_LOGIC_VECTOR (7 downto 0);  -- Entradas de 8 bits
        OP   : in  STD_LOGIC;                      -- Operação: 0 = Soma, 1 = Subtração
        S    : out STD_LOGIC_VECTOR (7 downto 0);  -- Saída do resultado
        Luz1 : out STD_LOGIC;                      -- Luz para soma
        Luz2 : out STD_LOGIC                       -- Luz para subtração
    );
end Calculadora;

architecture Etrutural of Calculadora is -- Arquitetura estrutural da Calculadora
    signal temp : STD_LOGIC_VECTOR (7 downto 0);  -- Sinal temporário para o resultado
begin
    process(A, B, OP) 
    begin
        case OP is
            when '0' =>      -- Operação de Soma
                temp <= A + B;
                Luz1 <= '1'; -- Acende luz da soma
                Luz2 <= '0'; -- Apaga luz da subtração
               
            when '1' =>      -- Operação de Subtração
                temp <= A - B;
                Luz1 <= '0'; -- Apaga luz da soma
                Luz2 <= '1'; -- Acende luz da subtração
               
            when others =>   -- Caso default (não deve ocorrer)
                temp <= (others => '0');
                Luz1 <= '0';
                Luz2 <= '0';
        end case;
    end process;
   
    S <= temp;  -- Atribui o resultado à saída
end Etrutural;