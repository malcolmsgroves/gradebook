require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "requires first and last name" do
    user = User.new(
      email: 'student@email.com',
      password: 'password123',
      password_confirmation: 'password123')
    assert_not user.save
    user.first_name = "Jim"
    assert_not user.save
    user.last_name = "Green"
    assert user.save!
  end
end
