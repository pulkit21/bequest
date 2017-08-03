class InsurancesController < ApplicationController

  before_action :set_base_path, only: [:apply, :confirm]
  before_action :set_insurance, only: [:show, :update, :destroy, :stripe, :signature]

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

  def stripe
    @insurance.submit_card_details_in_stripe(params)
    if @insurance.update(stripe_response: params[:stripe_response], terms_and_services: params[:terms_and_services])
      render :show, format: :json, status: 201
    else
      render json: @insurance.errors, status: :unprocessable_entity
    end
  end

  def update
    if @insurance.update(insurance_params)
      render :show, format: :json, status: 201
    else
      render json: @insurance.errors, status: :unprocessable_entity
    end

  end

  def signature
    @url = {
        url: @insurance.sign_policy
      }
    render json: @url, status: 200
  end


  def apply

  end

  def confirm
    if params[:event] == "signing_complete"
      @insurance = Insurance.find(params[:insurance])
      if @insurance.present?
        @insurance.get_combined_document(envelope_id: params[:envelope_id], document_id: 1)
        @insurance.update_columns(aasm_state: "signature")
      end
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

  def set_base_path
    @base_path = '/insurance/'
  end

  def set_insurance
    @insurance = Insurance.find(params[:id])
  end
end
