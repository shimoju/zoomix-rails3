# encoding: UTF-8
require 'spec_helper'

describe PlayerController do
  describe "の'index'をログインせずにGETしたとき" do
    it "は、root_urlにリダイレクトされること" do
      get 'index'
      expect(response).to redirect_to(root_url)
    end
  end
end
