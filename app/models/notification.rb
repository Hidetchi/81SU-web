class Notification < ActionMailer::Base

  def registered(player, sent_at = Time.now)
    subject    '[81Dojo] ' + I18n.t('activate.title')
    recipients player.email
    from       'info@81dojo.com'
    sent_on    sent_at
    body       :name => player.name, :key => player.salt[20, 20]
  end

  def reset_pass_url(player, ip, sent_at = Time.now)
    subject    '[81Dojo] Password Reset'
    recipients player.email
    from       'info@81dojo.com'
    sent_on    sent_at
    body       :name => player.name, :key => player.salt[20, 20], :ip => ip
  end

  def reset_pass_done(player, ip, newpass, sent_at = Time.now)
    subject    '[81Dojo] New Password'
    recipients player.email
    from       'info@81dojo.com'
    sent_on    sent_at
    body       :name => player.name, :newpass => newpass, :ip => ip
  end

end
