class Validation
    
    def initialize(e)
        @exp = e
    end
    
    def is_valid
        s = @exp.split(" ");
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
        
        if bracket != 0
            return [false, "Error: Missing brackets"]
            #@logger.error("  Error: Missing brackets")
            valid = false
        end
        
        return evaluate(e)
        
    end

    def evaluate(e)
        
        c = e[0].split(".")
        begin
            #try to find the corresponding type in codnitions
            type = Conditions::CONDS[c[0].to_sym][:fields][c[1].to_sym][:type]
        rescue
            #if attribute is wrong, it will throw an excepption
            return [false, "Error: Unidentified object: #{e[0]}"]
        end
        
        op = e[1]
        val = e[2]
      
        #try to find the operator op in the operators hash
        is_op_correct = false
        Conditions::OPERATORS_LIST.each do |k,v|
            if v[:operator] == op ||  v[:front_exp] == op
                is_op_correct = true
                break
            end
        end
    
        if !is_op_correct 
            return [false, "Error: operator is not correct"]
        end
    
        #check if value type is corresponding to condition type
        is_type_correct = true
        
        case type
        when Conditions::TYPES[:number]
            #matches signed floats
            is_type_correct = (/^[+-]?([0-9]+[.])?[0-9]+$/ === val)
            
            if !is_type_correct
                return [false, "Error: value type is not a NUMBER"]
            end
        
        when Conditions::TYPES[:boolean]
            is_type_correct = (val == "false" || val == "true")
            if !is_type_correct 
                return [false, "Error: value type is not a BOOLEAN"]
            end
        when Conditions::TYPES[:string]
            is_type_correct = (val.start_with?("'") && val.end_with?("'"))
            if !is_type_correct 
                return [false, "Error: value type is not a STRING"]
            end
        end
            
        return [true, "Success"]
    
    end

end