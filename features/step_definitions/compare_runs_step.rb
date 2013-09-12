When /^a team member checks compare runs of "(.*?)" "(.*?)" "(.*?)" with Date as "(.*?)" and "(.*?)"$/ do |project, sub_project, test_type, date1, date2|
  view_compare_run(project, sub_project, test_type, date1, date2)
end

Then /^the compare runs for "(.*?)" is plotted for Date "(.*?)" and "(.*?)"$/ do |sub_project, date1, date2|
  verify_if_compare_run_table_is_plotted(sub_project, date1, date2)
  verify_if_message_is_displayed(date1, date2)
end

Given(/^the following failure pattern$/) do |table|  	
	day1 = []
	day2 = []	
	data = table.hashes
	
	data.each do |hash|
		day1 << hash["day1"] unless  hash["day1"] == "" or hash["day1"] == "none" 
		day2 << hash["day2"] unless  hash["day2"] == ""	or hash["day2"] == "none" 
	end

	puts "day1 failures: #{day1}"
	puts "day2 failures: #{day2}"
	  
end

When(/^I compare the runs$/) do
  
end

Then(/^I see the following failures listed$/) do |table|  
	
	day1 = []
	day2 = []
	combined = []
	common = []
	data = table.hashes

	data.each do |hash|
		day1 << hash["day1"] unless  hash["day1"] == "" or hash["day1"] == "none"
		day2 << hash["day2"] unless  hash["day2"] == ""	or hash["day2"] == "none"
		combined << hash["combined"] unless  hash["combined"] == ""	or hash["combined"] == "none"
		common << hash["common"] unless  hash["common"] == ""	or hash["common"] == "none"
	end

	puts "day1 failures #{day1}"
	puts "day2 failures #{day2}"
	puts "combined failures #{combined}"
	puts "common failures #{common}"
	  
end
