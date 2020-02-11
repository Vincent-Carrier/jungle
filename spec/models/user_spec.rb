require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    mock_user = User.new(name: "Vincent", email: "v@mail.com", password: "qwerty", password_confirmation: "qwerty")
    
    it 'should be be valid' do
      expect(mock_user).to be_valid
      mock_user.save
      expect(mock_user.errors.full_messages).to eql([])
    end

    it 'should have the confirmation match the password' do
      mock_user.update password: "somethingelse"
      expect(mock_user.errors.full_messages).to eql(["Password confirmation doesn't match Password"])
    end

    it "should be at least 5 characters" do
      mock_user.password = "123"
      expect(mock_user).not_to be_valid
    end

    it "should have a unique email and not be case-sensitive" do
      mock_user.save
      expect(mock_user).not_to be_valid
    end

    it "should have a name" do
      mock_user.update name: nil
      expect(mock_user).not_to be_valid
    end

    it "should have an email" do
      mock_user.update email: nil
      expect(mock_user).not_to be_valid
    end

  end
end
