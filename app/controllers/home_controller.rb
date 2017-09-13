class HomeController < ApplicationController
  before_action :set_header_footer, only: [:terms, :privacy, :learn, :landing, :about, :index]

  def index
  end

  def landing

  end

  def design
    
  end

  def about

  end

  def terms
    
  end

  def privacy
        
  end

  def learn

  end

  def confirm_email

  end

  def insurance_coverage

  end

  def user_exist

  end

  #######
  private
  #######

  def set_header_footer
    @header_footer_on = true
  end

end
