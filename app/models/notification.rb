class Notification < ActionMailer::Base

  def registered(player, sent_at = Time.now)
    subject    '[81Dojo] Thank you for registering!'
    recipients player.email
    from       'info@81dojo.com'
    sent_on    sent_at
    body       :name => player.name, :key => player.salt[20, 20]
  end

end
