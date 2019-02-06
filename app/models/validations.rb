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
                if valid != true
                    return valid
                end
                e = []
                next
            end
            e << i
        end
        
        if bracket != 0
            return "Error: Missing brackets"
        end
        
        #the last part of the expression
        return evaluate(e)
        
    end

    def evaluate(e)
        c = e[0].split(".")
        begin
            #try to find the corresponding type in conditions
            type = Conditions::CONDS[c[0].to_sym][:fields][c[1].to_sym][:type]
        rescue
            #if attribute is wrong, it will throw an exception
            return "Error: Unidentified object: #{e[0]}"
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
            return "Error: operator is not correct"
        end
    
        #check if value type is corresponding to condition type
        is_type_correct = true
        
        case type
        when Conditions::TYPES[:number]
            #matches signed floats
            if !(/^[+-]?([0-9]+[.])?[0-9]+$/ === val)
                return "Error: value type is not a NUMBER"
            end
        when Conditions::TYPES[:boolean]
            if val != "false" && val != "true"
                return "Error: value type is not a BOOLEAN"
            end
        when Conditions::TYPES[:string]
            if !(val.start_with?("'") && val.end_with?("'")) 
                return "Error: value type is not a STRING"
            end
        end
            
        return true
    
    end

end