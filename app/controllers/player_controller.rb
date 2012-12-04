class PlayerController < ApplicationController
  before_filter :authenticate_user!
  layout 'minimal'

  def index
    @title = 'Play'
  end
end
