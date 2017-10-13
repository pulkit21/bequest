class InsurancesController < ApplicationController
  before_action :set_header_footer, only: []
  before_action :check_insurance, only: [:product]
  before_action :set_user, only: [:create]
  before_action :set_base_path, only: [:product, :confirm, :quote, :denied]
  before_action :set_insurance, only: [:show, :update, :destroy, :stripe, :signature, :download_policy]

  def index
    @insurances = Insurance.all
    render :index, status: 200
  end

  def show
    render :show, status: 200
  end

  def create
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
    begin
      if @insurance.update(insurance_params)
        render :show, format: :json, status: 201
      else
        render json: @insurance.errors, status: :unprocessable_entity
      end
    rescue ActiveRecord::NestedAttributes::TooManyRecords
      render json: {error: "Can save only upto five beneficiaries"}, status: :unprocessable_entity
    end

  end

  def signature
    @signature_link = ::DocusignService.new.sign_policy(@insurance)
    @url = {
        url: @signature_link
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


  def product
    @user = User.find(params[:user])
    if @user.present?
      if @user.insurances.present? && @user.insurances.count > 1
        redirect_to user_exist_path
      end
    end
  end

  def quote
    # @insurance = Insurance.find(params[:insurance])
  end

  def confirm
    if params[:event] == "signing_complete"
      @insurance = Insurance.find(params[:insurance])
      if @insurance.present?
        unless @insurance.policy.present?
          ::DocusignService.new.get_combined_document(@insurance, envelope_id: params[:envelope_id], document_id: 1)
          @insurance.update_columns(aasm_state: "signature")
        end
      end
    end
  end

  def revert_back
    @insurance = Insurance.find(params[:insurance][:id])
    if @insurance.update_previous_state
      render :show, format: :json, status: 201
    else
      render json: @insurance.errors, status: :unprocessable_entity
    end
  end

  def denied

  end




  #######
  private
  #######

  def set_header_footer
    @header_footer_on = true
  end

  def check_insurance
    # unless params[:user].present?
    #   render_404
    # end
  end

  def set_user
    @user = User.find(params[:insurance][:user_id])
    if @user.insurances.present?
      @user.insurances.first.update(insurance_params)
      @insurance = @user.insurances.first
    else
      @insurance = @user.insurances.new(insurance_params)
    end
  end

  def insurance_params
    params.require(:insurance).permit(:tobacco_product,
                              :health_condition,
                              :gender,
                              :birthday,
                              :height,
                              :height_inches,
                              :weight,
                              :coverage_amount,
                              :coverage_age,
                              :coverage_payment,
                              :payment_frequency,
                              :terms_and_services,
                              :aasm_state,
                              :driving_license,
                              :address,
                              :city,
                              :state,
                              :zipcode,
                              :phone_number,
                              :product,
                              :alcohol,
                              :blood,
                              :cholesterol,
                              :driving,
                              :family_history,
                              :occupation,
                              beneficiaries_attributes: [
                                :id,
                                :first_name,
                                :last_name,
                                :relation,
                                :allocated_percentage,
                                :birthday,
                                :_destroy
                              ]
                            )
  end

  def set_base_path
    @base_path = '/insurance/'
  end

  def set_insurance
    @insurance = Insurance.find(params[:id])
  end
end
