# encoding: UTF-8
require 'spec_helper'

describe "welcome/index.html.erb" do
  it "に、auth/twitterへのリンクが表示されていること" do
    render
    expect(rendered).to include("auth/twitter")
  end
end
