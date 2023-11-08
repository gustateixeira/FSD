--------------------------------------------------------------------------------
-- RELOGIO DE XADREZ
-- Author - Gustavo Teixeira e Gustavo Munoz 08/11/2023
--------------------------------------------------------------------------------
library IEEE;
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
library work;

entity relogio_xadrez is
    port(reset : in std_logic;
		clock : in std_logic;
		load : in std_logic;
		init_time : in std_logic_vector(7 downto 0);
		j1, j2 : in std_logic;
		contj1, contj2 : out std_logic_vector(15 downto 0);
		winJ1, winJ2 : out std_logic);
end relogio_xadrez;

architecture relogio_xadrez of relogio_xadrez is
    -- DECLARACAO DOS ESTADOS
    type states is (IDLE, TURNJ1, TURNJ2);
	signal EA, PE : states;
	signal enj1, enj2 : std_logic := '0';
	signal contj1_int : std_logic_vector(15 downto 0);
	signal contj2_int : std_logic_vector(15 downto 0);
    -- ADICIONE AQUI OS SINAIS INTERNOS NECESSARIOS
    
begin
	--INSTANCIACAO DO TEMPORIZADOR
	--clock, reset, load, en : in std_logic;
    -- init_time : in  std_logic_vector(7 downto 0);
	-- cont      : out std_logic_vector(15 downto 0)
    contador1 : entity work.temporizador port map 
		( 
		reset => reset,
		clock => clock, 
		load => load, 
		init_time => init_time,
		en => enj1,
		cont => contj1_int)
		;
    contador2 : entity work.temporizador port map
	( 	
		reset => reset,
		clock => clock, 
		load => load, 
		init_time => init_time,
		en => enj2,
		cont => contj2_int
	);

    -- PROCESSO DE TROCA DE ESTADOS
    process (clock, reset)
    begin
        if reset = '1' then
			EA <= IDLE;
		elsif clock'event and clock = '1' then
			EA <= PE;
			contj1 <= contj1_int;
			contj2 <= contj2_int;
		end if;
    end process;
    process (EA, j1, j2)
    begin
        case EA is
			when IDLE =>
				if j1 = '1' then
					PE <= TURNJ1;
					enj2 <= '0';
					enj1 <= '1';
				elsif j2 = '1'then
					PE <= TURNJ2;
					enj1 <= '0';
					enj2 <= '1';
				else
					PE <= IDLE;
					enj2 <= '0';
					enj1 <= '0';
				end if;
			when TURNJ1 =>
				if j1 = '1' then
					PE <= TURNJ2;
					enj1 <= '0';
					enj2 <= '1';
				else 
					PE <= TURNJ1;
					enj1 <= '1';
					enj2 <= '0';
				end if;
			when TURNJ2 =>
				if j2 = '1' then
					PE <= TURNJ1;
					enj1 <= '1';
					enj2 <= '0';
				else
					PE <= TURNJ2;
					enj2 <= '1';
					enj1 <= '0';
				end if;
			when others =>
				PE <= IDLE;
			end case;
		end process;
    process (EA, contj1_int, contj2_int)
		begin
        winJ1  <=  '0';
        winj2   <=  '0';

        case EA is
            when IDLE =>
                winJ1   <=  '0';
                winJ2   <=  '0';
            when TURNJ1 =>
                if contj1_int = x"0000" then
                    winJ2 <= '1';
                    winJ1 <= '0';
                end if;
            when TURNJ2 =>
                if contj2_int = x"0000" then
                    winJ2 <= '0';
                    winJ1 <= '1';
                end if;
            when others =>
                winJ1   <=  '0';
                winJ2   <=  '0';
		end case;
	end process;
end relogio_xadrez;


