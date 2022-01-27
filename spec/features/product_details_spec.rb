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
  # Click button for details on first product:
    first('.btn-default').click
  # Confirm the product is being showed:
    expect(page).to have_css 'article.product-detail'
    save_screenshot
  end
end
