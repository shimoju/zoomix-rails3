# encoding: UTF-8
require 'spec_helper'

describe PlayerController do
  describe "の'play'をログインせずにGETしたとき" do
    it "は、root_urlにリダイレクトされること" do
      get 'play'
      expect(response).to redirect_to(root_url)
    end
  end
end
