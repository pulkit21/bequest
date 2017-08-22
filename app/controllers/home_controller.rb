class HomeController < ApplicationController
  before_action :set_header_footer, only: [:blog, :learn, :landing, :about, :index]

  def index
  end

  def landing

  end

  def about

  end

  def blog

  end

  def learn

  end

  #######
  private
  #######

  def set_header_footer
    @header_footer_on = true
  end

end
