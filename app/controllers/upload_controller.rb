require 'xmlsimple'
require 'ftools'
require 'net/scp'


class UploadController < ApplicationController


  def create
    project = Project.find_or_create_by_name(params[:project_name])
    sub_project = project.sub_projects.find_or_create_by_name(params[:sub_project_name])

    meta_datum = sub_project.test_metadatum.find_or_create_by_ci_job_name_and_browser_and_type_of_environment_and_host_name_and_os_name_and_test_category_and_test_report_type(params[:ci_job_name],
                  params[:browser],params[:type_of_environment],params[:host_name],params[:os_name],params[:test_category],params[:test_report_type])

    meta_datum.date_of_execution= params[:test_metadatum][:date_of_execution]
    if meta_datum.save
    

    path = params[:logDirectory]+"/asd.xml"
    #We need file pattern , but right now it has not been used
    #+params[:filePattern]
    puts ("*")*100
    puts path


    #All files are copied in the same folder "tta"
    #For adding files to a new folder , create the folder and change the path here

    Net::SCP::start("10.12.6.142","tta", :password => "ttas") do |scp|
        scp.download!(path, "/home/aasawaree/testFiles/")
        parse_xml("/home/aasawaree/testFiles/asd.xml",meta_datum.id)
     end

    redirect_to :action => :show, :project_id => project.id, :sub_project_id => sub_project.id, :project_meta_id => meta_datum.id
    else
      flash[:project_error] = project.errors.messages
      flash[:sub_project_error] = sub_project.errors.messages
      flash[:meta_data_error] = meta_datum.errors.messages
      render 'upload/upload'
    end
  end

  def show
    @project = Project.find(params[:project_id])
    @sub_project= @project.sub_projects.find(params[:sub_project_id])
    @project_meta = @sub_project.test_metadatum.find(params[:project_meta_id])
    begin
      respond_to do |format|
        flash[:notice] = "Project Successfully Saved!!"
        format.html
        format.json { render json: @project }
      end
    end
  end

  def parse_xml(config_xml, meta_id)
    config = XmlSimple.xml_in(config_xml, {'KeyAttr' => 'name'})
    @xml_data = TestRecord.new()
    @xml_data.test_metadatum_id=meta_id
    @xml_data.class_name= config['name']
    @xml_data.number_of_errors= config['errors']
    @xml_data.number_of_failures= config['failures']
    @xml_data.number_of_tests= config['tests']
    @xml_data.time_taken= config['time']
    @xml_data.save

  end

end
