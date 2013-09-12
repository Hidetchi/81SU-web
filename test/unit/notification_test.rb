require 'test_helper'

class NotificationTest < ActionMailer::TestCase
  test "registered" do
    @expected.subject = 'Notification#registered'
    @expected.body    = read_fixture('registered')
    @expected.date    = Time.now

    assert_equal @expected.encoded, Notification.create_registered(@expected.date).encoded
  end

end
