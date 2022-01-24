require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "validations" do

    it "will save if all validations are present" do
      @category = Category.new
      @product = Product.new(name:"name", price: 1.99, quantity: 12, category: @category)
      @product.save!
      expect(@product.id).to be_present
    end

    it "will not validate if name is not present" do
      @category = Category.new
      @product = Product.new(name: nil, price: 1.99, quantity: 12, category: @category)
      @product.validate
      expect(@product.errors.full_messages).to include("Name can't be blank") 
    end

    it "will not validate if price is not present" do
      @category = Category.new
      @product = Product.new(name: "name", price: nil, quantity: 12, category: @category)
      @product.validate
      expect(@product.errors.full_messages).to include("Price can't be blank") 
    end

    it "will not validate if quanitity is not present" do
      @category = Category.new
      @product = Product.new(name: "name", price: 1.99, quantity: nil, category: @category)
      @product.validate
      expect(@product.errors.full_messages).to include("Quantity can't be blank") 
    end

    it "will not validate if category is not present" do
      @category = Category.new
      @product = Product.new(name: "name", price: 1.99, quantity: 12, category: nil)
      @product.validate
      expect(@product.errors.full_messages).to include("Category can't be blank") 
    end
  end
end
