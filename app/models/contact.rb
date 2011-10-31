class Contact < Object
  include ActiveModel::Validations
  include ActiveModel::Naming
  include ActiveModel::Conversion
  
  attr_accessor :name, :email, :subject, :message

  validates :name, :email, :message, :subject, :presence => true, :length => { :minimum => 3 }
  validates :email, :format => { :with => %r{.+@.+\..+} }, :allow_blank => true

  #Modified initialize to provide behavior closer to ActiveRecord::Base
  def initialize(attributes = nil)
    @name = attributes[:name] unless attributes.nil?
    @email = attributes[:email] unless attributes.nil?
    @subject = attributes[:subject] unless attributes.nil?
    @message = attributes[:message] unless attributes.nil?
  end

  def persisted?
    false
  end
end
