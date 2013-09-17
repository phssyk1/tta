module Domain
  module CompareRun
    
    def view_compare_run(project, sub_project, test_type, date1, date2)
      navigate_to_homepage()
      go_to_url(COMPARE_RUNS_PAGE)
      view_compare_run_data(project, sub_project, test_type, date1, date2)
    end

    def verify_if_compare_run_table_is_plotted(sub_project, date1, date2)
      wait_until_for { page.has_css?(COMPARE_RUN_TABLE_ID) }
      assert page.has_css?(COMPARE_RUN_TABLE_ID), "Compare run table is displayed"
    end

    def verify_if_message_is_displayed(date1, date2)
      wait_until_for { page.has_content?('TEST-CASES FAILING ON BOTH '+date1+' AND '+date2) }
      assert page.has_content?('TEST-CASES FAILING ON BOTH '+date1+' AND '+date2), "nil"
    end

    def classnames_listed_for_table(tablename)
      all(:xpath , "//table[@id='#{tablename}']/tbody/tr/td").map{|t| t.native.text} - [""]
    end

  end
end

module CompareRunsSpecHelper
  def create_test_suites
    @metadata1 = create_metadatum(@sub_project , @jan_1_2013 , @unit_tests)
    @metadata2 = create_metadatum(@sub_project , @jan_2_2013 , @unit_tests)
    @suite1 = create_suite_with_metadata(@metadata1 , "suite001")
    @suite2 = create_suite_with_metadata(@metadata2 , "suite002")
  end

  def class_error_hash_from(*class_names)
    result_hash = {}
    class_names.each do |class_name|
        result_hash[class_name] = "error message for #{class_name}" 
    end
    result_hash
  end
end

module CompareRunsCustomMatchers
    RSpec::Matchers.define :contain_all do |expected|
      match do |actual|
        (actual.length == expected.length ) and (actual.to_set == expected.to_set)
      end
    end

    RSpec::Matchers.define :contain_none_of do |expected|
        match do |actual|
            expected & actual == []
        end
    end
end

World(Domain::CompareRun)
World(DataHelper)
World(CompareRunsSpecHelper)
World(CompareRunsCustomMatchers)



