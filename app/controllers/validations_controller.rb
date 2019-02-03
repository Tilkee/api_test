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
    
      expr = @validation.get_exp();
      s = expr.split(" ");
      e = []
      bracket = 0
      valid = true
      
      s.each do |i|
        if i == '('
          bracket-=1
          next
        end
        if i == ')'
          bracket+=1
          next
        end
        if i == "&&" || i == "||"
          valid = evaluate(e)
          e = []
          next
        end
        e << i
      end
      valid = evaluate(e)
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
      c = e[0].split(".")
      begin
        type = @conds[c[0].to_sym][:fields][c[1].to_sym][:type]
      rescue
        logger.error "  Error: Unidentified object: #{e[0]}"
        return false
      end
    
      op = e[1]
      val = e[2]
    
      is_op_correct = false
      @ops.each do |k,v|
        if v[:operator] == op ||  v[:front_exp] == op
          is_op_correct = true
          break
        end
      end
    
      if !is_op_correct 
        logger.error "  Error: operator is not correct"
        return false
      end
    
      is_type_correct = true
      case type
      when "number"
        is_type_correct = (/^[+-]?([0-9]+[.])?[0-9]+$/ === val)
        if !is_type_correct
          logger.error "  Error: value type is not a NUMBER"
        end
      when "boolean"
        is_type_correct = (val == "false" || val == "true")
        if !is_type_correct 
          logger.error "  Error: value type is not a BOOLEAN"
        end
      when "string"
        is_type_correct = (val.start_with?("'") && val.end_with?("'"))
        if !is_type_correct 
          logger.error "  Error: value type is not a STRING"
        end
      end
        
      if !is_type_correct
        return false
      else
        return true
      end
    
  end
  
  # Only allow a trusted parameter "white list" through.
  def validation_params
      params.require(:validation)
  end

end
