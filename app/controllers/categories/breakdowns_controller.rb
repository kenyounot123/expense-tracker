class Categories::BreakdownsController < ApplicationController
  def index
    @categories = Current.user.categories
  end
end
