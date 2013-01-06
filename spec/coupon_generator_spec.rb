require "spec_helper"
require_relative "../coupon_generator"
require_relative "../gift"

describe CouponGenerator do

  before do
    @gifts = {}
    @gifts["coffee"]   = Gift.new("coffee 4")
    @gifts["chocolate"] = Gift.new("chooclate 10")
    @gifts["movie"]    = Gift.new("movie 84")
    @gifts["smoothie"] = Gift.new("smoothie 16")
    @gifts["cap"]       = Gift.new("cap 24")
  end

  let(:coupon) { CouponGenerator.new(@gifts) }

  it "should generate the max number of gifts specified" do
    coupon.gifts.count.should eql 5
  end
  
  context "TEST DATA" do
    before do
      coupon.assign_to_credit("100 movie coffee coffee chocolate smoothie")
      coupon.assign_to_credit("86 !movie cap chocolate cap coffee cap smoothie")
      coupon.assign_to_credit("88 cap movie smoothie coffee")
      coupon.assign_to_credit("8 cap cap coffee coffee")
      coupon.assign_to_credit("52 movie smoothie cap cap coffee")
    end

    describe ".assign_to_credit" do
      it "should assign gifts to credits" do
        list = coupon.credit_gifts_list
        ["100", "86", "88" "8", "52"].each do |key|
          list.should have_key("100")
        end
        list["100"].should eql ["movie", "coffee", "coffee", "chocolate" , "smoothie"]
        list["86"].should  eql ["!movie", "cap", "chocolate", "cap", "coffee", "cap", "smoothie"] 
        list["88"].should  eql ["cap", "movie", "smoothie", "coffee"]
        list["8"].should   eql ["cap", "cap", "coffee", "coffee"]
        list["52"].should  eql ["movie", "smoothie", "cap", "cap", "coffee"]
      end
    end

    describe ".allowed_gifts" do
      it "should display allowed gifts" do
        coupon.allowed_gifts.should eql "movie smoothie\ncap cap cap chocolate coffee\nmovie coffee\ncoffee coffee\ncap cap coffee"
      end
    end
  end

end
