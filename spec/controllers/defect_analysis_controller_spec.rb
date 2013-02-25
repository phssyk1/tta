require 'spec_helper'


describe DefectAnalysisController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      expect(response).to be_success
      expect(response.code).to eq("200")
    end
  end


  it"should throw error if sub_project id and date not given" do
    expect{DefectAnalysis.get_result_json(nil,nil)}.to raise_error
  end

  it"should throw error if sub_project id not given" do
    expect{DefectAnalysis.get_result_json(nil,'2012-02-17')}.to raise_error
  end

  it"should throw error if date not given" do
    expect{DefectAnalysis.get_result_json(:id,nil)}.to raise_error
  end

  it "expects an appropriate flash message if no failing tests" do
    sub_project = FactoryGirl.create(:sub_project)

    analysis_date = '2012-12-12'
    post :sub_project_filter , :sub_project => {:id => sub_project.id} , :defect_analysis=> {:analysis_date => analysis_date}

    assert_response :success
    @controller.expects(:create)
    assert_not_nil assigns(@json)
    assert_not_nil flash[:no_errors]
    assert_equal flash[:no_errors], "No failing tests on #{analysis_date} for the selected Sub Project"
  end

  it "expects an appropriate flash message if no built run on that particular date" do

    sub_project = FactoryGirl.create(:sub_project)
    analysis_date = '2010-12-12'
    post :sub_project_filter , :sub_project => {:id => sub_project.id} , :defect_analysis=> {:analysis_date => analysis_date}

    assert_response :success
    @controller.expects(:create)
    assert_not_nil assigns(@json)
    assert_not_nil flash[:no_errors]

  end

end