library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity SevenSegmentDecoder is
	port(
		B0 : in std_logic;
		B1 : in std_logic;
		B2 : in std_logic;
		B3 : in std_logic;
		output0 : out std_logic; 
		output1 : out std_logic;
		output2 : out std_logic;
		output3 : out std_logic;
		output4 : out std_logic;
		output5 : out std_logic;
		output6 : out std_logic);
		
end SevenSegmentDecoder;

architecture STRUCTURAL of SevenSegmentDecoder is

begin
	output0 <= B0 OR B2 OR (B1 AND B3) OR (NOT B1 AND NOT B3);
	output1 <= (NOT B1) OR (NOT B2 AND NOT B3) OR (B2 AND B3);
	output2 <= B1 OR NOT B2 OR B3;
	output3 <= (NOT B1 AND NOT B3) OR (B2 AND NOT B3) OR (B1 AND NOT B2 AND B3) OR (NOT B1 AND B2) OR B0;
	output4 <= (NOT B1 AND NOT B3) OR (B2 AND NOT B3);
	output5 <= B0 OR (NOT B2 AND NOT B3) OR (B1 AND NOT B2) OR (B1 AND NOT B3);
	output6 <= B0 OR (B1 AND NOT B2) OR ( NOT B1 AND B2) OR (B2 AND NOT B3);
end STRUCTURAL;