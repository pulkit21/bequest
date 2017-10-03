class DocusignService

  def initialize

  end


  def initialize_net_http_ssl(uri)
    http = Net::HTTP.new(uri.host, uri.port)

    http.use_ssl = uri.scheme == 'https'

    if defined?(Rails) && Rails.env.test?
      in_rails_test_env = true
    else
      in_rails_test_env = false
    end

    if http.use_ssl? && !in_rails_test_env
      # Explicitly verifies that the certificate matches the domain.
      # Requires that we use www when calling the production DocuSign API
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER
      http.verify_depth = 5
    else
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end

    http
  end


  # TODO make Docu service
  def get_combined_document(insurance, options={})
    headers = {
      "X-DocuSign-Authentication"=>
        "{\"Username\":\"#{Rails.application.secrets.docosign_username}\",\"Password\":\"#{Rails.application.secrets.docosign_password}\",\"IntegratorKey\":\"#{Rails.application.secrets.docosign_integration_key}\"
      }",
      "Accept"=>"json",
      "Content-Type"=>"application/json"
    }
    uri = URI.parse("https://demo.docusign.net/restapi/v2/accounts/#{Rails.application.secrets.docosign_account_id}/envelopes/#{options[:envelope_id]}/documents/combined")

    http = initialize_net_http_ssl(uri)
    request = Net::HTTP::Get.new(uri.request_uri, headers)
    response = http.request(request)
    obj = ::AmazonS3Service.new.save_pdf(options[:envelope_id], response)
    insurance.update_columns(policy: obj.key)
    # Insurance.first.get_combined_document(envelope_id: "45bfa861-509b-4088-8e89-9de255ee6088", document_id: 1)
  end

  def add_commas_to_numbers(num_string)
    num_string.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
  end

  # Sign the document using
  # TODO- Add the user specifc data
  def sign_policy(insurance)
    client = DocusignRest::Client.new
    file_io = open(Rails.application.secrets.document_url)
    document_envelope_response = client.create_envelope_from_document(
      email: {
        subject: "Coverage Policy",
        body: "this is the email body and it's large!"
      },
      signers: [
        {
          embedded: true,
          name: insurance.user.full_name,
          email: insurance.user.email,
          role_name: 'Issuer',
          sign_here_tabs: [
            {
              anchor_string: "SIGNATURE",
              anchor_x_offset: '210',
              anchor_y_offset: '-15'
            }
          ],
          text_tabs: [
            {
              label: "NAME OF INSURED",
              name: "NAME OF INSURED",
              locked: true,
              page_number: 2,
              font: "Calibri",
              font_size: "Size10",
              bold: true,
              font_color: "Gold",
              x_position: '155',
              y_position: '132',
              value: insurance.user.full_name
            },
            {
              label: "ADDRESS OF INSURED",
              name: "ADDRESS OF INSURED",
              locked: true,
              page_number: 2,
              font: "Calibri",
              font_size: "Size10",
              bold: true,
              font_color: "Gold",
              x_position: '165',
              y_position: '156',
              value: insurance.full_address
            },
            {
              label: "CONTRACT NUMBER",
              name: "CONTRACT NUMBER",
              locked: true,
              font_color: "Gold",
              font: "Calibri",
              font_size: "Size10",
              bold: true,
              x_position: '160',
              y_position: '181',
              page_number: 2,
              value: ActiveSupport::NumberHelper.number_to_phone(insurance.phone_number, country_code: 1)
            },
            {
              label: "COVERAGE AMOUNT",
              name: "COVERAGE AMOUNT",
              locked: true,
              page_number: 2,
              font: "Calibri",
              font_size: "Size10",
              bold: true,
              font_color: "Gold",
              x_position: '160',
              y_position: '205',
              value: "$#{add_commas_to_numbers(insurance.coverage_amount)}"
            },
            {
              label: "PREMIUM PAYMENT",
              name: "PREMIUM PAYMENT",
              locked: true,
              page_number: 2,
              font: "Calibri",
              font_size: "Size10",
              bold: true,
              font_color: "Gold",
              x_position: '160',
              y_position: '229',
              value: "$#{insurance.coverage_payment} #{insurance.payment_frequency.upcase}"
            },
            {
              label: "INSURED ISSUE AGE",
              name: "INSURED ISSUE AGE",
              locked: true,
              page_number: 2,
              font: "Calibri",
              font_size: "Size10",
              bold: true,
              font_color: "Gold",
              x_position: '155',
              y_position: '253',
              value: "#{insurance.current_age}"
            },
            {
              label: "GENDER",
              name: "GENDER",
              locked: true,
              page_number: 2,
              font: "Calibri",
              font_size: "Size10",
              bold: true,
              font_color: "Gold",
              x_position: '110',
              y_position: '278',
              value: "#{insurance.gender.capitalize}"
            },
            {
              label: "PAYABLE TO",
              name: "PAYABLE TO",
              locked: true,
              page_number: 2,
              font: "Calibri",
              font_size: "Size10",
              bold: true,
              font_color: "Gold",
              x_position: '125',
              y_position: '303',
              value: "AGE 65"
            },
            {
              label: "EFFECTIVE DATE",
              name: "EFFECTIVE DATE",
              locked: true,
              page_number: 2,
              font: "Calibri",
              font_size: "Size10",
              bold: true,
              font_color: "Gold",
              x_position: '140',
              y_position: '327',
              value: "#{insurance.effective_date}"
            },
            {
              label: "MATURITY DATE",
              name: "MATURITY DATE",
              locked: true,
              page_number: 2,
              font: "Calibri",
              font_size: "Size10",
              bold: true,
              font_color: "Gold",
              x_position: '140',
              y_position: '351',
              value: "#{insurance.maturity_date}"
            },
            {
              label: "DATE",
              name: "DATE",
              locked: true,
              page_number: 2,
              font: "Calibri",
              font_size: "Size10",
              bold: true,
              font_color: "Gold",
              x_position: '107',
              y_position: '470',
              value: "#{insurance.current_date}"
            }
          ]
        },
      ],
      files: [
        {io: file_io, name: 'policy.pdf'},
      ],
      status: 'sent'
    )
    insurance.update_columns(docusign_response: document_envelope_response)
    url = client.get_recipient_view(
        envelope_id: insurance.docusign_response['envelopeId'],
        name: insurance.user.full_name,
        email: insurance.user.email,
        return_url: "#{ActionMailer::Base.default_url_options[:host]}/insurance/confirm?insurance=#{insurance.id}&envelope_id=#{insurance.docusign_response['envelopeId']}"
      )['url']
    url
  end


end
