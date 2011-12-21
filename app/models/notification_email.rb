class NotificationEmail < Object
  def self.get_gmail_atom
    # open-uri doesn't seem to be able to handle https (maybe it's the auth parms, unsure)
    notifications_account = RestClient::Resource.new 'https://mail.google.com/a/alertzy.com/feed/atom', :user => 'Notifications@alertzy.com', :password => 'applesauce55'
    SimpleRSS.parse ( notifications_account.get )
  end
end


