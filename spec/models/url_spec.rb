# encoding: UTF-8
require 'spec_helper'

describe Url do
  describe "に、必須のフィールドが設定されていないとき" do
    before(:each) do
      @url = Url.new
    end
    it "は、バリデーションに失敗すること" do
      expect(@url).not_to be_valid
    end
    it "は、必須のフィールドそれぞれにエラーが設定されていること" do
      expect(@url).to have(1).errors_on(:original_url)
      expect(@url).to have(1).errors_on(:url)
    end
  end
end
