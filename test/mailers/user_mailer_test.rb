require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "granted_staff_access" do
    mail = UserMailer.granted_staff_access
    assert_equal "Granted staff access", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "named_star_writer" do
    mail = UserMailer.named_star_writer
    assert_equal "Named star writer", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
