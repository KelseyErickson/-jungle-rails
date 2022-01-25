require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do

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
  end
end
