require 'rails_helper'

RSpec.describe User, type: :model do
  describe User do
    subject(:user) do
      FactoryGirl.build(:user,
        username: "matt",
        password: "123456")
    end

    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_length_of(:password).is_at_least(6) }

    it "creates a password digest when a password is given" do
      expect(user.password_digest).to_not be_nil
    end

    it "creates a session token before validation" do
      user.valid?
      expect(user.session_token).to_not be_nil
    end

    it "returns session token when calling reset session token" do
      expect(user.reset_session_token).to eq(user.session_token)
    end

    it "returns nil if it does not find user" do
      expect(User.find_by_credentials("jim", "654321")).to be_nil
    end

    it "creates a password digest using password" do
      user.password = "123456"
      expect(user.password_digest).to be_a(String)
    end

    it "returns true when given a valid password" do
      expect(user.is_password?("123456")).to be true
    end
  end
end
