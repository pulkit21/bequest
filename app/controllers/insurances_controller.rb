class InsurancesController < ApplicationController

  before_action :set_insurance, only: [:show, :update, :destroy]

  def index
    @insurances = Insurance.all
    render :index, status: 200
  end

  def show
    render :show, status: 200
  end

  def create
    @insurance = Insurance.new(insurance_params)
    if @insurance.save
      render :show, status: 201
    else
      render json: @insurance.errors, status: :unprocessable_entity
    end
  end

  def chart_data
  end

  def learn

  end

  def blog

  end


  def update
    if @insurance.update(insurance_params)
      render :show, format: :json, status: 201
    else
      render json: @insurance.errors, status: :unprocessable_entity
    end

  end





  #######
  private
  #######

  def insurance_params
    params.require(:insurance).permit(:tobacco_product,
                              :health_condition,
                              :gender,
                              :birthday,
                              :height,
                              :weight,
                              :coverage_amount,
                              :coverage_age,
                              :coverage_payment,
                              :payment_frequency,
                              :terms_and_services,
                              :aasm_state
                            )
  end

  def set_insurance
    @insurance = Insurance.find(params[:id])
  end
end
