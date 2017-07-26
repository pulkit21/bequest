require "rails_helper"

RSpec.describe InsurancesController, type: :routing do

  describe "routing" do
    it "routes to #index" do
      expect(get: "api/v1/insurances").to route_to("insurances#index", format: :json)
    end

    it "routes to #create" do
      expect(post: "api/v1/insurances").to route_to("insurances#create", format: :json)
    end

    it "routes to #show" do
      expect(get: "api/v1/insurances/433f7094-7415-43c8-9331-d431b3048b5a").to route_to("insurances#show", id: "433f7094-7415-43c8-9331-d431b3048b5a", format: :json)
    end

    it "routes to #update" do
      expect(put: "api/v1/insurances/433f7094-7415-43c8-9331-d431b3048b5a").to route_to("insurances#update", id: "433f7094-7415-43c8-9331-d431b3048b5a", format: :json)
    end

    # it "routes to #destroy" do
    #   expect(delete: "api/v1/insurances/433f7094-7415-43c8-9331-d431b3048b5a").to route_to("insurances#destroy", id: "433f7094-7415-43c8-9331-d431b3048b5a", format: :json)
    # end
  end
end
