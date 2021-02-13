library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Blinker is
	port(
		clk: in std_logic;
		A0, A1, A2: out std_logic;
		ss0: out std_logic_vector(3 downto 0);
		ss1: out std_logic_vector(3 downto 0);
		mm0: out std_logic_vector(3 downto 0);
		mm1: out std_logic_vector(3 downto 0);
		hh0: out std_logic_vector(3 downto 0);
		hh1: out std_logic_vector(3 downto 0);
		selector: out std_logic_vector(3 downto 0));
end Blinker;

architecture Behav of Blinker is

signal counter1: integer := 1; 
signal clk1: std_logic := '0';
signal counter2: integer := 1; 
signal clk2: std_logic := '0';
signal counter3: integer := 1; 
signal clk3: std_logic := '0';
signal position : integer := 0;
signal neededPos : std_logic_vector(2 downto 0);
signal seconds0: integer := 0;
signal minutes0: integer := 0;
signal hours0: integer := 0;
signal seconds1: integer := 0;
signal minutes1: integer := 0;
signal hours1: integer := 0;
signal selectorr: std_logic_vector(3 downto 0) := "0000";

begin 

p0 : process(clk)
begin
	if (clk'event and clk = '1')
		then counter1 <= counter1 + 1; counter2 <= counter2 + 1; counter3 <= counter3 + 1;
		if(counter1 = 40000)
			then clk1 <= not clk1; counter1 <= 1;
		end if;
		if(counter2 = 25000000)
			then clk2 <= not clk2; counter2 <= 1;
		end if;
		if(counter3 = 40000)
			then clk3 <= not clk3; counter3 <= 1;
		end if;
	end if;
end process;

p1 : process(clk1)
begin
	if(clk1'event and clk1 = '1') then
		if (position = 5 ) then position <= 0;
		else position <= position + 1;
		end if;
	end if;
end process;

p2 : process(clk2)
begin 
	if(clk2'event and clk2 = '1') then
		if(seconds0 = 9) then 
			seconds0 <= 0; 
			if(seconds1 = 5) then 
				seconds1 <= 0;
				if(minutes0 = 9) then 
					minutes0 <= 0; 
					if(minutes1 = 5) then 
						minutes1 <= 0;
						if(hours0 = 9 and hours1 < 2) then
							hours0 <= 0; hours1 <= hours1 + 1;
						elsif(hours1 = 2 and hours0 = 3) then
							hours1 <= 0; hours0 <= 0;
						else hours0 <= hours0 + 1;
						end if;
					else minutes1 <= minutes1 + 1;
					end if;
				else minutes0 <= minutes0 + 1;
				end if;
			else seconds1 <= seconds1 + 1;
			end if;
		else seconds0 <= seconds0 + 1;
		end if;
	end if;
end process;

p3 : process(clk3)
begin
	if(clk3'event and clk3 = '1') then
		if(selectorr = "0000") then selectorr <= "0100";
		elsif(selectorr = "0100") then selectorr <= "1000";
		elsif(selectorr = "1000") then selectorr <= "1100";
		elsif(selectorr = "1100") then selectorr <= "0001";
		elsif(selectorr = "0001") then selectorr <= "0011";
		elsif(selectorr = "0011") then selectorr <= "0000";
		end if;
	end if;
end process;

					
neededPos <= conv_std_logic_vector(position, 3);
A0 <= neededPos(0);
A1 <= neededPos(1);
A2 <= neededPos(2);
ss0 <= conv_std_logic_vector(seconds0, 4);
ss1 <= conv_std_logic_vector(seconds1, 4);
mm0 <= conv_std_logic_vector(minutes0, 4);
mm1 <= conv_std_logic_vector(minutes1, 4);
hh0 <= conv_std_logic_vector(hours0, 4);
hh1 <= conv_std_logic_vector(hours1, 4);
selector <= selectorr;

end Behav;
		