When /^a team member checks compare runs of "(.*?)" "(.*?)" "(.*?)" with Date as "(.*?)" and "(.*?)"$/ do |project, sub_project, test_type, date1, date2|
  view_compare_run(project, sub_project, test_type, date1, date2)
end

Then /^the compare runs for "(.*?)" is plotted for Date "(.*?)" and "(.*?)"$/ do |sub_project, date1, date2|
  verify_if_compare_run_table_is_plotted(sub_project, date1, date2)
  verify_if_message_is_displayed(date1, date2)
end


class String
	def trim
		strip! || self
	end
end

Before do 
	self.use_transactional_fixtures = false
	clean_up_data
	perform_common_setup
	create_new_project_and_subproject
	create_test_suites
end

After do
	clean_up_data
end


Given(/^the following failure pattern$/) do |table|  			
	day1 = []
	day2 = []	
	data = table.hashes
	
	data.each do |hash|
		day1 << hash["day1"] unless  hash["day1"] == "" or hash["day1"] == "none" 
		day2 << hash["day2"] unless  hash["day2"] == ""	or hash["day2"] == "none" 
	end
	
	create_class_errors(@suite1,class_error_hash_from(*day1))
	create_class_errors(@suite2,class_error_hash_from(*day2))
end

When(/^I compare the runs$/) do
	navigate_to_homepage()
    go_to_url(COMPARE_RUNS_PAGE)
	page.driver.browser.manage.window.maximize
	view_compare_run_data(
		"COMPARE_RUNS_PROJECT",
		"COMPARE_RUNS_SUBPROJECT",
		"UNIT TESTS",
		@jan_1_2013.sub("UTC","").trim(),
		@jan_2_2013.sub("UTC","").trim())    

	 
end

Then(/^I see the following failures listed$/) do |table|  
	
	day1 = []
	day2 = []
	combined = []
	common = []
	
	data = table.hashes

	data.each do |hash|
		day1 << hash["day1"] unless hash["day1"] == "" or hash["day1"] == "none"
		day2 << hash["day2"] unless hash["day2"] == ""	or hash["day2"] == "none"
		combined << hash["combined"] unless  hash["combined"] == ""	or hash["combined"] == "none"
		common << hash["common"] unless  hash["common"] == "" or hash["common"] == "none"
	end

	classnames_listed_for_table("result_table_common").should contain_all(common )
	classnames_listed_for_table("result_table_both").should contain_all(combined )
	classnames_listed_for_table("result_table_date1").should contain_all(day1 )
	classnames_listed_for_table("result_table_date2").should contain_all(day2 )

end
