require 'rails_helper'

RSpec.describe ValidationsController, type: :controller do

  describe "POST #validate_post" do
    
    context "validate post request" do
      
      it "tests simple request that is 200 ok" do
        post :validate_post, params: {validation: "connexion.percentage_read > 50"}
        expect(response.code).to eq "200"
      end
      
      it "detects that complex request is 200 ok" do
        post :validate_post, params: {validation: "connexion.percentage_read > 50 && ( connexion.total_time > 2000 && connexion.total_time < 2020202020 )"}
        expect(response.code).to eq "200"
      end 
      
      it "detects that complex request with || operator is 200 ok" do
        post :validate_post, params: {validation: "connexion.percentage_read > 50 || connexion.total_time > 2000"}
        expect(response.code).to eq "200" 
      end 
      
      it "detects that simple request is 400 bad_request" do
        post :validate_post, params: {validation: "connexion.percentage_red > 50"}
        expect(response.code).to eq "400"
      end
      
      it "detects that a simple request with a bad (number) type is 400 bad_request" do
        post :validate_post, params: {validation: "connexion.percentage_read > 'bonjour'"}
        expect(response.code).to eq "400"
      end 
      
      it "detects that a simple request with a bad (string) type is 400 bad_request" do
        post :validate_post, params: {validation: "token.name =~ 12"}
        expect(response.code).to eq "400"
      end
      
      it "detects that a request containing an undefined object is 400 bad_request" do
        post :validate_post, params: {validation: "undefined_object.name =~ 'bonjour'"}
        expect(response.code).to eq "400"
      end
      
      it "detects that a request with missing brackets is 400 bad_request" do
        post :validate_post, params: {validation: "( connexion.percentage_read > 50"}
        expect(response.code).to eq "400"
      end
      
      it "detects that a request with a bad operator is 400 bad_request" do
        post :validate_post, params: {validation: "connexion.percentage_read >>> 50"}
        expect(response.code).to eq "400"
      end
    
    end
      
  end
 
end
