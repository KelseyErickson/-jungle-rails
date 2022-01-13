class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['ADMIN_USER'], password: ENV['ADMIN_PASSWORD']

  def show
    @total_products = Product.sum(:quantity)
    @total_categories = Category.count
  end
end
