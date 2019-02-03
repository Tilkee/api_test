require "rails_helper"

RSpec.describe ValidationsController, type: :routing do
  describe "routing" do
   
    it "routes to #validate_post" do
      expect(:post => "/validations/validate_post").to route_to("validations#validate_post")
    end

  end
end
