Feature: Simple Integration Test

	Scenario: Integration Test Scenario1
		Given: start ballpark
		When: open top page 
		Then: display character Ballpark

	Scenario: Integration Test Scenario2
		Given: start ballpark
		When: open top page 
		AND: input 1 to rs_0_num1
		AND : click calc button
		Then: display character HARDWARE

	Scenario: Integration Test Scenario3
		Given: start ballpark
		When: open top page 
		When: input 11 to rs_0_num1
		AND : click calc button
		Then: display character HHHARDWARE
