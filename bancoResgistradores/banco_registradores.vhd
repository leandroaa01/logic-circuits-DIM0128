library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity banco_registradores is
    Port (
        clk      : in  STD_LOGIC;
        reset    : in  STD_LOGIC;
        end_reg  : in  STD_LOGIC_VECTOR(2 downto 0);
        dado_ent : in  STD_LOGIC_VECTOR(15 downto 0);
        op       : in  STD_LOGIC;
        led_reg  : out STD_LOGIC_VECTOR(2 downto 0);
        dado_sai : out STD_LOGIC_VECTOR(15 downto 0);
        acao     : out STD_LOGIC
    );
end banco_registradores;

architecture Hierarquica of banco_registradores is
    component unidade_controle is
        Port (
            clk     : in  STD_LOGIC;
            reset   : in  STD_LOGIC;
            op      : in  STD_LOGIC; 
            estado  : out STD_LOGIC_VECTOR(1 downto 0)
        );
    end component;
    
    component caminho_dados is
        Port (
            clk       : in  STD_LOGIC;
            reset     : in  STD_LOGIC;
            estado    : in  STD_LOGIC_VECTOR(1 downto 0);
            end_reg   : in  STD_LOGIC_VECTOR(2 downto 0);
            dado_ent  : in  STD_LOGIC_VECTOR(15 downto 0);
            led_reg   : out STD_LOGIC_VECTOR(2 downto 0);
            dado_sai  : out STD_LOGIC_VECTOR(15 downto 0)
        );
    end component;
    
    signal estado : STD_LOGIC_VECTOR(1 downto 0);
begin
    -- Atribuição do sinal acao
    acao <= op;
    
    UC: unidade_controle
     port map (clk => clk, reset => reset,op => op,  estado => estado);
    
    CD: caminho_dados
    port map (clk => clk,reset => reset,estado => estado, end_reg => end_reg, 
       dado_ent => dado_ent, led_reg => led_reg, dado_sai => dado_sai );
end Hierarquica;