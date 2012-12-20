class PlayerController < ApplicationController
  before_filter :authenticate_user!
  layout 'minimal'

  def play
    @title = 'Play'
  end
end
