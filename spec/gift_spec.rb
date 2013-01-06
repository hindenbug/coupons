require "spec_helper"
require_relative "../gift"

describe Gift do
  
  let(:gift) { Gift.new("GIFT 100") }

  it "should have a name" do
    gift.name.should eql "GIFT"
  end

  it "should have a vlaue" do
    gift.value.should eql 100
  end


end
