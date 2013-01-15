# encoding: UTF-8
require 'spec_helper'

describe Content do
  describe "に、必須のフィールドが設定されていないとき" do
    before(:each) do
      @content = Content.new
    end
    it "は、バリデーションに失敗すること" do
      expect(@content).not_to be_valid
    end
  end
end
