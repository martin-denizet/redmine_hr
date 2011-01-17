class HrController < ApplicationController
  unloadable
  before_filter :authorize_global

  helper :positions

  def index

  end

end
