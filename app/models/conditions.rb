# Condition model with every operator and fields
class Conditions

  TYPES = {
    boolean: 'boolean',
    number: 'number',
    string: 'string'
  }.freeze

  OPERATORS_LIST = {
    equal: {
      operator: '==',
      front_exp: '='
    },
    greater_than: {
      operator: '>',
      front_exp: '>'
    },
    greater_than_or_equal_to: {
      operator: '>=',
      front_exp: '>='
    },
    less_than: {
      operator: '<',
      front_exp: '<'
    },
    less_than_or_equal_to: {
      operator: '<=',
      front_exp: '<='
    },
    and: {
      operator: '&&',
      front_exp: 'AND'
    },
    or: {
      operator: '||',
      front_exp: 'OR'
    },
    left_parenthesis: {
      operator: '(',
      front_exp: '('
    },
    right_parenthesis: {
      operator: ')',
      front_exp: ')'
    },
    include: {
      operator: '=~',
      front_exp: 'contains'
    }
  }.freeze

  CONDS = {
    token: {
      fields: {
        total_time:
        { 
          type: TYPES[:number],
          front_exp: 'temps total sur le lien'
        },
        percentage_read:
        { 
          type: TYPES[:number],
          front_exp: 'pourcentage de lecture sur le lien'
        },
        interest:
        { 
          type: TYPES[:number],
          front_exp: 'note d\'interet du lien'
        },
        nb_connections:
        { 
          type: TYPES[:number],
          front_exp: 'nombre total de connexion sur ce lien'
        },
        creator_id:
        { 
          type: TYPES[:number],
          front_exp: 'user id du créateur de ce lien'
        },
        id:
        { 
          type: TYPES[:number],
          front_exp: 'token id'
        },
        name:
        { 
          type: TYPES[:string],
          front_exp: 'nom du lien'
        }
      }
    },
    connexion: {
        fields: {
          downloaded:
          {
            type: TYPES[:boolean],
            front_exp: 'connexion telechargée'
          },
          total_time:
          { 
            type: TYPES[:number],
            front_exp: 'temps total sur la connexion'
          },
          percentage_read:
          { 
            type: TYPES[:number],
            front_exp: 'pourcentage de lecture sur la connexion'
          },
          most_visited_id:
          {
            type: TYPES[:number],
            front_exp: 'l\'item_id le plus visité sur la connexion'
          }
        }
      },
    project: {
        fields: {
          total_time:
          { 
            type: TYPES[:number],
            front_exp: 'temps total sur le projet'
          },
          median_percentage_read: 
          { 
            type: TYPES[:number],
            front_exp: 'pourcentage de lecture median sur le projet'
          },
          nb_links:
          { 
            type: TYPES[:number],
            front_exp: 'nombre total de lien sur ce projet'
          },
          nb_connections:
           {
            type: TYPES[:number],
            front_exp: 'nombre total de connexion sur ce projet'
          }
        }
      }
  }.freeze
  
  def self.types
    return TYPES
  end
  
  def self.ops
    return OPERATORS_LIST
  end
  
  def self.conds
    return CONDS
  end

  private


end

