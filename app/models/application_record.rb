class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  self.class_eval do 
    def identity_encode(value)
      if self.model_name.name == 'Assinatura'
        x = 13
      end

      return Base64.encode64((self.id * x).to_s)
    end
  
    def self.identity_decode(value, type)
      if type == 'Assinatura'
        x = 13
      end
      value = Base64.decode64(value).to_i    
      return value / x
    end
  end
end
