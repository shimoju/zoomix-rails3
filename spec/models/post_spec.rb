# encoding: UTF-8
require 'spec_helper'

describe Post do
  describe "に、必須のフィールドが設定されていないとき" do
    before(:each) do
      @post = Post.new
    end
    it "は、バリデーションに失敗すること" do
      expect(@post).not_to be_valid
    end
  end
end
