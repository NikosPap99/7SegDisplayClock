library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity Converter is
	port(
		clk: in std_logic;
		IN0, IN1, IN2, IN3, IN4, IN5, IN6: in std_logic;
		D0, D1, D2, D3, D4, D5, D6: out std_logic);
end Converter;

architecture Behav of Converter is

signal IN0IN1IN2IN3IN4IN5IN6: std_logic_vector(6 downto 0) := IN0&IN1&IN2&IN3&IN4&IN5&IN6;
signal D0D1D2D3D4D5D6: std_logic_vector(6 downto 0);
signal counter1: integer := 1;
signal clk1: std_logic := '0';
signal foundSix: std_logic := '0';

begin

p0: process(IN0IN1IN2IN3IN4IN5IN6, clk1)

begin

	if(clk1'event and clk1 = '1')
		then D0D1D2D3D4D5D6 <= "1111001"; -- 3
	end if;
	
	if(IN0IN1IN2IN3IN4IN5IN6 = "1111110")
		then D0D1D2D3D4D5D6 <= "1111110"; -- 0
	elsif(IN0IN1IN2IN3IN4IN5IN6 = "1111111")
		then D0D1D2D3D4D5D6 <= "0110000"; -- 1
	elsif(IN0IN1IN2IN3IN4IN5IN6 = "0110011")
		then D0D1D2D3D4D5D6 <= "1101101"; -- 2
	elsif(IN0IN1IN2IN3IN4IN5IN6 = "1101101")
		then D0D1D2D3D4D5D6 <= "0110011"; -- 4
	elsif(IN0IN1IN2IN3IN4IN5IN6 = "1101111")
		then D0D1D2D3D4D5D6 <= "1011011"; -- 5
	elsif(IN0IN1IN2IN3IN4IN5IN6 = "1011111" and foundSix = '0')
		then D0D1D2D3D4D5D6 <= "1011111"; foundSix <= '1'; -- 6
	elsif(IN0IN1IN2IN3IN4IN5IN6 = "1011111" and foundSix = '1')
		then D0D1D2D3D4D5D6 <= "1110000"; foundSix <= '0'; -- 7
	elsif(IN0IN1IN2IN3IN4IN5IN6 = "0110000")
		then D0D1D2D3D4D5D6 <= "1111111"; -- 8 
	elsif(IN0IN1IN2IN3IN4IN5IN6 = "1111011")
		then D0D1D2D3D4D5D6 <= "1111011"; -- 9 
	
	end if;

end process;

p1: process(clk)

begin 

	if(clk'event and clk = '1')
		then counter1 <= counter1 + 1;
		if(counter1 = 75000000)
			then clk1 <= not clk1; counter1 <= 1;
		end if;
	end if;
end process;

D0 <= D0D1D2D3D4D5D6(6);
D1 <= D0D1D2D3D4D5D6(5);
D2 <= D0D1D2D3D4D5D6(4);
D3 <= D0D1D2D3D4D5D6(3);
D4 <= D0D1D2D3D4D5D6(2);
D5 <= D0D1D2D3D4D5D6(1);
D6 <= D0D1D2D3D4D5D6(0);

end Behav;
			