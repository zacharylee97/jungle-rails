require 'rails_helper'

RSpec.feature "Visitor navigates to product details", type: :feature, js: true do
  #SETUP
  before :each do
    @category = Category.create! name: "Apparel"
    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They click on a product and see the product details" do
    #ACT
    visit root_path
    first(".product").click_link("Details \u00BB")
    #DEBUG
    save_screenshot
    #VERIFY
    expect(page).to have_current_path "/products/10"
    expect(page).to have_css "article.product-detail"
  end
end