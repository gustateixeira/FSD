--------------------------------------------------------------------------------
-- TB do cronometro de xadrez
-- Fernando Moraes - 25/out/2023
--------------------------------------------------------------------------------
library IEEE;
use ieee.std_logic_1164.all;

entity tb is
end tb;

architecture arch of tb is
    signal init_time        : std_logic_vector(7 downto 0);
    signal cont             : std_logic_vector(15 downto 0);
    signal enable, reset, load, ck  : std_logic := '0' ;
 

begin

    reset <= '1', '0' after 5 ns;

    ck <= not ck after 5 ns;

    load <= '0', '1' after 15 ns, '0' after 30 ns;

    enable <=  '0', '1' after 45 ns;

    init_time <= x"99";


    contador1 : entity work.temporizador
        port map ( reset => reset, clock => ck, load => load, en => enable, init_time => init_time, cont => cont );

 

end arch;




