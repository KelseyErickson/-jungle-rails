require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do

    it "will save if validations are present" do
      @user = User.new(first_name:"name", last_name:"last_name", email:"sample@email.com", password: "password1234", password_confirmation: "password1234")
      @user.save!
      expect(@user.id).to be_present
    end

    #password validations

    it "will not validate without a password" do
      @user = User.new(first_name:"name", last_name:"last_name", email:"sample@email.com", password: nil, password_confirmation: nil)
      @user.validate
      expect(@user.errors.full_messages).to include("Password can't be blank") 
    end

    it "will not validate without a password confirmation" do
      @user = User.new(first_name:"name", last_name:"last_name", email:"sample@email.com", password: "password1234", password_confirmation: nil)
      @user.validate
      expect(@user.errors.full_messages).to include("Password confirmation can't be blank") 
    end

    it "will not validate without if password and password confirmation are not the same" do
      @user = User.new(first_name:"name", last_name:"last_name", email:"sample@email.com", password: "password1234", password_confirmation:"lemongrab1234")
      @user.validate
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password") 
    end

    it "will have a password of at least 8 characters" do
      @user = User.new(first_name:"name", last_name:nil, email: "sample@email.com", password: "123", password_confirmation: "123")
      @user.validate
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 8 characters)") 
    end
    #email validations

    it "will not validate if email has been registered" do
      @user = User.new(first_name:"name", last_name:"last_name", email:"sample@email.com", password: "password1234", password_confirmation: "password1234")
      @user.save!
      @user2 = User.new(first_name:"name", last_name:"last_name", email:"sample@email.com", password: "password1234", password_confirmation: "password1234")
      @user2.validate
      expect(@user2.errors.full_messages).to include("Email has already been taken") 
    end

    it "will not validate without an email" do
      @user = User.new(first_name:"name", last_name:"last_name", email: nil, password: "password1234", password_confirmation: "password1234")
      @user.validate
      expect(@user.errors.full_messages).to include("Email can't be blank") 
    end

    it "will remove spaces around the email" do
      @user = User.new(first_name:"name", last_name:"last_name", email: "  sample@email.com ", password: "password1234", password_confirmation: "password1234")
      @user.save!
      expect(@user.email).to eq("sample@email.com")
    end

    #name validations

    it "will not validate without a first name" do
      @user = User.new(first_name: nil, last_name:"last_name", email: "sample@email.com", password: "password1234", password_confirmation: "password1234")
      @user.validate
      expect(@user.errors.full_messages).to include("First name can't be blank") 
    end

    it "will not validate without a last name" do
      @user = User.new(first_name:"name", last_name:nil, email: "sample@email.com", password: "password1234", password_confirmation: "password1234")
      @user.validate
      expect(@user.errors.full_messages).to include("Last name can't be blank") 
    end
  end

  describe ".authenticate_with_credentials" do
    it "will return nil if no user is found" do
      @result = User.authenticate_with_credentials("sample@email.com", "password1234")
      expect(@result).to be_nil
    end

    it "will return user if user is found" do
      @user = User.new(first_name:"name", last_name: "last_name", email: "sample@email.com", password: "12345678", password_confirmation: "12345678")
      @user.save!
      @result = User.authenticate_with_credentials("sample@email.com", "12345678")
      expect(@result).to eq(@user)
    end

    it "will return user even if email is in a different case" do
      @user = User.new(first_name:"name", last_name: "last_name", email: "SamPLE@eMail.com", password: "12345678", password_confirmation: "12345678")
      @user.save!
      @result = User.authenticate_with_credentials("SAMPLE@email.com", "12345678")
      expect(@result).to eq(@user)
    end
  end

end
