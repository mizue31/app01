Feature: Simple Integration Test

	Background:
		Given start ballpark

	Scenario: Integration Test Scenario1
		Given start ballpark
		When open top page 
		Then display character Ballpark

	Scenario: Integration Test Scenario3
		Given start ballpark
		When open top page 
		Then display character Ballpark
		And input 2 to rs_1_num1
		And click Calculate button
		Then display result character HARDWARE

	Scenario: Integration Test Scenario3
		Given: start ballpark
		When open top page 
		Then display character Ballpark
		And input 11 to rs_1_num1
		And click Calculate button
		Then display result character HARDWARE
