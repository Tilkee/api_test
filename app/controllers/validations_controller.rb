class ValidationsController < ApplicationController
  
  require('validations')
  
  # POST /validations
  def validate_post
      
      validation = Validation.new(params.require(:validation)).is_valid
      
      if validation == true
        render :status => :ok
      else
        render :status => :bad_request, :json => {message: validation}
      end
      
  end
  
end