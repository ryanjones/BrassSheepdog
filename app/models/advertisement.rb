class Advertisement < ActiveRecord::Base
  belongs_to :service
  
  # date run length attr? from date a to date b?
  # need validations
  # let the user pick the services they want the ads for (relationship)
end
