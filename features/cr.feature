Feature: Compare Runs

Scenario: No failures on either days
	
	Given the following failure pattern
	|day1		|day2		|
	|class_001	|class_001	|		
	|class_002  |class_002 	|
	
	When I compare the runs
	
	Then I see the following failures listed
	|day1		| day2		| combined		| common		|
	|class_001	| class_001	| class_001		| class_001		|
	|class_002	| class_002	| class_002		| class_002		|

