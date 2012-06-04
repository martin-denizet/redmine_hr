class HrUserDetailsController < ApplicationController
  unloadable

  helper :hr

  helper :custom_fields

  before_filter :authorize_global

  #  def new
  #    @user= User.find(params[:user_id])
  #    @hr_user_details = HrUserDetails.new(:user => @user)
  #  end
  #
  #  def create
  #    @user= User.find(params[:user_id])
  #    @hr_user_details = HrUserDetails.new(params[:hr_user_details])
  #    if @hr_user_details.save
  #      flash[:notice] = "Successfully created User Details."
  #      render :action => 'show'
  #    else
  #      render :action => 'new'
  #    end
  #  end

  #  def show
  #    @user = User.find(params[:id])
  #  end

  def edit
    @user = User.find(params[:id])
    @hr_user_details = HrUserDetails.find(:first, :conditions => ["user_id=?", @user.id])
    if @hr_user_details == nil
      @hr_user_details = HrUserDetails.new(:user_id => @user.id)
    end

  end

  def update
    @user = User.find(params[:id])
    @hr_user_details = HrUserDetails.find(:first, :conditions => ["user_id=?", @user.id])
    @hr_user_details = HrUserDetails.new(:user_id => @user.id) unless @hr_user_details

    @user.update_attributes(params[:user_custom_fields])
    @hr_user_details.update_attributes(params[:hr_user_details])
    if @user.save and @hr_user_details.save
      flash[:notice] = l(:notice_successful_update)
    end
    redirect_to :action=>'edit'
  end
end
