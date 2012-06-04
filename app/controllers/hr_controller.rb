class HrController < ApplicationController
  unloadable
  before_filter :authorize_global

  before_filter {User.send(:include, HrUserPatch) unless User.included_modules.include?(HrUserPatch)} if RAILS_ENV == 'development'

  helper :hr_job_titles
  helper :custom_fields

  def index

  end

  def contact_list
    @hr_organization = params[:id] ? HrOrganization.find(params[:id], :include => [:departments]):HrOrganization.find(:first, :include => [:departments])
    @show_private=false
    #@hr_organizations = @hr_organization.self_and_descendants
  end

  def employees_information
    @hr_organization = params[:id] ? HrOrganization.find(params[:id], :include => [:departments]):HrOrganization.find(:first, :include => [:departments])
    @show_private=true
    #@hr_organizations = @hr_organization.self_and_descendants
  end

end
