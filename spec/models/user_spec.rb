require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do

    it "will save if validations are present" do
      @user = User.new(first_name:"name", last_name:"last_name", email:"sample@email.com", password: "password1234", password_confirmation: "password1234")
      @user.save!
      expect(@user.id).to be_present
    end

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

    it "will not validate if email has been registered" do
      @user = User.new(first_name:"name", last_name:"last_name", email:"sample@email.com", password: "password1234", password_confirmation: "password1234")
      @user.save!
      @user2 = User.new(first_name:"name", last_name:"last_name", email:"SAMPLE@email.com", password: "password1234", password_confirmation: "password1234")
      @user2.validate
      expect(@user2.errors.full_messages).to include("Email has already been taken") 
    end

    it "will not validate without an email" do
      @user = User.new(first_name:"name", last_name:"last_name", email: nil, password: "password1234", password_confirmation: "password1234")
      @user.validate
      expect(@user.errors.full_messages).to include("Email can't be blank") 
    end

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

    it "will not validate without a last name" do
      @user = User.new(first_name:"name", last_name:nil, email: "sample@email.com", password: "password1234", password_confirmation: "password1234")
      @user.validate
      expect(@user.errors.full_messages).to include("Last name can't be blank") 
    end

    it "will have a password of at least 8 characters" do
      @user = User.new(first_name:"name", last_name:nil, email: "sample@email.com", password: "123", password_confirmation: "123")
      @user.validate
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 8 characters)") 
    end
  end
end
