class NotificationEmail < Object
  def self.get_gmail_atom
    # open-uri doesn't seem to be able to handle https (maybe it's the auth parms, unsure)
    SimpleRSS.parse ( RestClient.get 'https://alertzymail:applesauce55@mail.google.com/mail/feed/atom')
  end
end