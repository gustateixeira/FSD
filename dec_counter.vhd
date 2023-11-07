--------------------------------------------------------------------------------
-- Temporizador decimal do cronometro de xadrez
-- Fernando Moraes - 25/out/2023
--------------------------------------------------------------------------------
library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
library work;

entity dec_counter is
    port( clock, reset, load, en : in std_logic;
          first_value : in  std_logic_vector(3 downto 0);
          limit       : in  std_logic_vector(3 downto 0);
          cont        : out std_logic_vector(3 downto 0)
    );
end dec_counter;

architecture a1 of dec_counter is
    signal cont_int: std_logic_vector(3 downto 0);
begin

    ct : process (reset, clock)
    begin
        if reset='1' then
            cont_int <= (others => '0'); -- contador inicializado em zero
        elsif rising_edge(clock) then

            if load='1' then -- quando a entrada LOAD está ativa o contador carrega o valor FIRST_VALUE
                cont_int <= first_value;
            elsif en='1'then -- quando EN está ativo e LOAD desativado o contador ira decrementar
                if cont_int = x"0" then -- caso o contador esteja em zero, irá para LIMIT
                    cont_int <= limit;
                else -- caso seja qualquer valor maior que zero, ira decrementar em 1
                    cont_int <= cont_int - 1;
                end if;
         
            end if;
        end if;
    end process;

    cont <= cont_int; -- faz a atribuicao do contador para a saida

end a1;