class ValidationsController < ApplicationController
  
  require('validations')
  
  # POST /validations
  def validate_post
      
      validation = Validation.new(params.require(:validation)).is_valid
      
      if validation[0]
        render :status => :ok, :json => validation[1]
      else
        render :status => :bad_request, :json => validation[1]
      end
      
  end
  
end
