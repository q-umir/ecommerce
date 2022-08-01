class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def homepage
    redirect_to categories_path
  end
end
