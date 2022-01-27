require 'rails_helper'

RSpec.feature "Visitor navigates from hompage to product details", type: :feature, js: true do

  before :each do
    @category = Category.create! name: "Apparel"

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They will click a product to view the product details" do
  # visit home page:
    visit root_path
    within('nav'){expect(page).to have_content('My Cart (0)')}

  # Click 'Add to Cart' button
    first('.btn-primary').click

  # Confirm cart is updated by one
    within('nav'){expect(page).to have_content('My Cart (1)')}
    save_screenshot
  end
end
