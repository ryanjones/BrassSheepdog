class Advertisement < ActiveRecord::Base
  has_and_belongs_to_many :services
  
  # date run length attr? from date a to date b?
  # need validations
  # let the user pick the services they want the ads for (relationship)
end
