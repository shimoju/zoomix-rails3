class WelcomeController < ApplicationController
  skip_before_filter :authorize

  def index
  end

  def about
    @title = 'About'
  end
end
