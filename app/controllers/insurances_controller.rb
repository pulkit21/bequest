class InsurancesController < ApplicationController

  before_action :check_insurance, only: [:apply]
  before_action :set_user, only: [:create]
  before_action :set_base_path, only: [:apply, :confirm]
  before_action :set_insurance, only: [:show, :update, :destroy, :stripe, :signature, :download_policy]

  def index
    @insurances = Insurance.all
    render :index, status: 200
  end

  def show
    render :show, status: 200
  end

  def create
    @insurance = @user.insurances.new(insurance_params)
    if @insurance.save
      render :show, status: 201
    else
      render json: @insurance.errors, status: :unprocessable_entity
    end
  end

  def chart_data
  end

  def stripe
    @stripe_response = @insurance.submit_card_details_in_stripe(params)
    if !@stripe_response[:error_status]
      if @insurance.update(stripe_response: params[:stripe_response], terms_and_services: params[:terms_and_services])
        render :show, format: :json, status: 201
      else
        render json: @insurance.errors, status: :unprocessable_entity
      end
    else
      render json: {error: @stripe_response[:message]} , status: :unprocessable_entity
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

  def download_policy
    @insurance.update_columns(aasm_state: "confirmation")
    @policy_link = ::AmazonS3Service.new.policy_link(@insurance)
    @policy_link = {
        url: @policy_link
      }
    render json: @policy_link, status: 200
  end


  def apply
    @user = User.find(params[:user])
    if @user.present?
      if @user.insurances.present?
        redirect_to user_exist_path
      end
    end
  end

  def confirm
    if params[:event] == "signing_complete"
      @insurance = Insurance.find(params[:insurance])
      if @insurance.present?
        unless @insurance.policy.present?
          @insurance.get_combined_document(envelope_id: params[:envelope_id], document_id: 1)
          @insurance.update_columns(aasm_state: "signature")
        end
      end
    end
  end




  #######
  private
  #######

  def check_insurance
    unless params[:user].present?
      render_404
    end
  end

  def set_user
    @user = User.find(params[:insurance][:user_id])
  end

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
                              :aasm_state,
                              :driving_license
                            )
  end

  def set_base_path
    @base_path = '/insurance/'
  end

  def set_insurance
    @insurance = Insurance.find(params[:id])
  end
end
