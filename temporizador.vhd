-------------------------------------------------------------------------------- 
-- Temporizador decimal do cronometro de xadrez
-- Fernando Moraes - 25/out/2023
--------------------------------------------------------------------------------
library IEEE;
use ieee.std_logic_1164.all;
library work;

entity temporizador is
    port( clock, reset, load, en : in std_logic;
          init_time : in  std_logic_vector(7 downto 0);
          cont      : out std_logic_vector(15 downto 0)
      );
end temporizador;

architecture a1 of temporizador is
    signal segL, segH, minL, minH : std_logic_vector(3 downto 0);
    signal en1, en2, en3, en4: std_logic;
begin
	 process(clock, reset)
    begin
        if reset = '1' then
            en1 <= '0';
            en2 <= '0';
            en3 <= '0';
            en4 <= '0';	
        elsif rising_edge(clock) then
              if en = '1' and not (segL = "0000" and segH = "0000" and minL = "0000" and minH = "0000") then
                en1 <= '1';
            else
                en1 <= '0';
            end if;
            if segL = "0000" and en1 = '1' then
                en2 <= '1';
            else
                en2 <= '0';
            end if;
            if segH = "0000" and en2 = '1' then
                en3 <= '1';
            else
                en3 <= '0';
            end if;
            if minL = "0000" and en3 = '1' then
                en4 <= '1';
            else
                en4 <= '0';
            end if;
        end if;
    end process;
   sL : entity work.dec_counter port map 
   (	
		clock => clock,
		reset => reset,
		load => load,
		en => en1,
		first_value => x"0",
		limit =>  x"9",
		cont => segL
    );
   sH : entity work.dec_counter port map (
		clock => clock,
		reset => reset,
		load => load,
		en => en2,
		first_value => x"0",
		limit =>  x"5",
		cont => segH);
   mL : entity work.dec_counter port map 
   ( 
		clock => clock,
		reset => reset,
		load => load,
		en => en3,
		first_value => init_time(3 downto 0),
		limit =>  x"9",
		cont => minL
   );
   mH : entity work.dec_counter port map 
   ( 
		clock => clock,
		reset => reset,
		load => load,
		en => en4,
		first_value => init_time(7 downto 4),
		limit =>  x"9",
		cont => minH		
    );
   
   cont <= minH & minL & segH & segL;
end a1;


