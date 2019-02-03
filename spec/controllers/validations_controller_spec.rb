require 'rails_helper'

RSpec.describe ValidationsController, type: :controller do
logger = Rails.logger
  describe "POST #validate_post" do
    context "validate post request" do
      
      it "detects if 200 ok" do
        logger.info "Test 1"
        post :validate_post, params: {validation: "connexion.percentage_read > 50"}
        expect(response.code).to eq "200"
        
        logger.info "Test 2"
        post :validate_post, params: {validation: "connexion.percentage_read > 50 && ( connexion.total_time > 2000 && connexion.total_time < 2020202020 )"}
        expect(response.code).to eq "200"
      end
      
      it "detects if 400 bad request" do
        logger.info "Test 3"
        post :validate_post, params: {validation: "connexion.percentage_red > 50"}
        expect(response.code).to eq "400"
        
        logger.info "Test 4"
        post :validate_post, params: {validation: "connexion.percentage_read > 'bonjour'"}
        expect(response.code).to eq "400"
        
        logger.info "Test 5"
        post :validate_post, params: {validation: "token.name =~ 12"}
        expect(response.code).to eq "400"
        
        logger.info "Test 6"
        post :validate_post, params: {validation: "undefined_object.name =~ 'bonjour'"}
        expect(response.code).to eq "400"
        
        
      end
    end
      
  end

 
end
