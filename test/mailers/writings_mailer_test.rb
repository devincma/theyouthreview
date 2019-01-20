require 'test_helper'

class WritingsMailerTest < ActionMailer::TestCase
  test "writing_featured" do
    mail = WritingsMailer.writing_featured
    assert_equal "Writing featured", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "writing_featured_for_banner" do
    mail = WritingsMailer.writing_featured_for_banner
    assert_equal "Writing featured for banner", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
