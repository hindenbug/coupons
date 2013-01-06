require_relative "gift"
require_relative "coupon_generator"
require "debugger"

puts "Enter number of gifts: "
@max_gifts = gets.chomp!.to_i
@gifts     = {}


def generate_gifts
  @max_gifts.times do |i|
    puts "Enter Gift #{i+1}'s Name and Value:"
    gift = Gift.new(gets.chomp)
    @gifts[gift.name] = gift.value
  end
end

generate_gifts
coupon = CouponGenerator.new(@gifts)
puts "Enter credits followed by gifts:"
inpu =  gets.chomp!

unless input == "END"
 coupon.assign_to_credit(input)
 input = gets.chomp!
end

coupon.allowed_gifts

