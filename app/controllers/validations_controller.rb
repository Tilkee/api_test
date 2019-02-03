class ValidationsController < ApplicationController
  require('validations')
  require('conditions')
  
  
  # POST /validations
  def validate_post
    logger = Rails.logger
    @validation = Validation.new(validation_params)
    @types = Conditions.types()
    @ops = Conditions.ops()
    @conds = Conditions.conds()
    
    e = @validation.get_exp();
    s = e.split();
    
    i = 0; len = s.length; bracket = 0
    valid = true
    while i <= len && valid
      if i == len
        valid = evaluate(e)
        break
      end
      if s[i] == "("
        bracket-=1
        i+=1
        next
      end
      if s[i] == ")"
        bracket+=1
        i+=1
        next
      end
      if s[i] == "&&" || s[i] == "||"
        valid = evaluate(e)
        e = nil
        i+=1
        next
      end
      e = s[i..i+3]
      i+=3
    end
    if bracket != 0
      valid = false
      logger.error("  Error: Missing brackets")
    end
    if valid
      render :status => :ok
    else
      render :status => :bad_request
    end
  end
  
  def evaluate(e)
    valid = false
    c = e[0].split(".")
    begin
      type = @conds[c[0].to_sym][:fields][c[1].to_sym][:type]
    rescue
      logger.error "  Error: Unidentified object: #{e[0]}"
      return valid
    end
    
    op = e[1]
    val = e[2]
    
    @ops.each do |k,v|
      if v[:operator] == op ||  v[:front_exp]
        valid = true
        break
      end
    end
    
    case type
    when "number"
      valid = (/^[+-]?([0-9]+[.])?[0-9]+$/ === val)
      if !valid
        logger.error "  Error: value type is not a NUMBER"
      end
    when "boolean"
      valid = (val == "false" || val == "true")
      if !valid 
        logger.error "  Error: value type is not a BOOLEAN"
      end
    when "string"
      valid = (val.start_with?("'") && val.end_with?("'"))
      if !valid 
        logger.error "  Error: value type is not a STRING"
      end
    end
        
    return valid
  end
  
  # Only allow a trusted parameter "white list" through.
  def validation_params
    params.require(:validation)
  end
  
end
