# encoding: UTF-8
require 'spec_helper'

describe User do
  describe "に、必須のフィールドが設定されていないとき" do
    before(:each) do
      @user = User.new
    end
    it "は、バリデーションに失敗すること" do
      expect(@user).not_to be_valid
    end
  end
end
