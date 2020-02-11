require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    before(:each) do
      User.destroy_all
      @user = User.new(name: "Vincent", email: "v@mail.com",
                       password: "qwerty", password_confirmation: "qwerty")
    end
    
    it 'should be be valid' do
      expect(@user).to be_valid
    end

    it 'should have the confirmation match the password' do
      @user.update password: "somethingelse"
      expect(@user.errors.full_messages).to eql(["Password confirmation doesn't match Password"])
    end

    it "should be at least 5 characters" do
      @user.password = "123"
      expect(@user).not_to be_valid
    end

    it "should have a unique email" do
      @user.save
      @user2 = User.new(name: "Vincent", email: "v@mail.com",
                        password: "qwerty", password_confirmation: "qwerty")
      expect(@user2).not_to be_valid
    end

    it "should ignore case for email" do
      @user.email = "V@MAIL.COM"
      expect(@user).to be_valid
    end

    it "should have a name" do
      @user.name = nil
      @user.save
      expect(@user).not_to be_valid
    end

    it "should have an email" do
      @user.email = nil
      @user.save
      expect(@user).not_to be_valid
    end
  end
end
