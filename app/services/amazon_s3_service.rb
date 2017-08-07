class AmazonS3Service

  def initialize
    @aws_credentials = Aws::Credentials.new(Rails.application.secrets.aws_access_key, Rails.application.secrets.aws_secret_key)
    @s3 = Aws::S3::Resource.new(
          region: Rails.application.secrets.aws_region,
          credentials: @aws_credentials
        )
  end

  def save_pdf(envelope, http_response)
    @obj = @s3.bucket(Rails.application.secrets.s3_bucket).object("Insurances/#{envelope}.pdf")
    File.open('/', 'rb')do |file|
      @obj.put(body: http_response.body)
    end
    @obj
  end

  def policy_link(insurance)
    @insurance = insurance
    @policy_link = insurance.policy
    obj = @s3.bucket(Rails.application.secrets.s3_bucket).object(@policy_link)

    link = obj.presigned_url(:get)
    link
  end
end
