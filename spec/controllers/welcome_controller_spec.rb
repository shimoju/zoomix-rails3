# encoding: UTF-8
require 'spec_helper'

describe WelcomeController do
  describe "の'index'をGETしたとき" do
    it "は、http successが返ってくること" do
      get 'index'
      expect(response).to be_success
    end
  end
end
