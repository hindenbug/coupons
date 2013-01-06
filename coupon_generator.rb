class CouponGenerator

  attr_accessor :gifts, :credit_gifts_list

  def initialize(gifts)
    @credit_gifts_list = {}
    @gifts = gifts
  end


  def assign_to_credit(input)
    get_gifts_for_credit(input)
  end

  def allowed_gifts
    out = []
    @credit_gifts_list.each do |key, value|
      out << max_value_gifts_for(key.to_i, value)
    end
    out.map {|x| x.join(" ")}.join("\n")
  end

  private

  def get_gifts_for_credit(input)
    new_input = input.split || []
    key       = new_input.slice!(0)
    @credit_gifts_list[key] = new_input
  end

  def max_value_gifts_for(key, values)
    #### in the PROB STATEMENT is says "now allowed ( with a ! mark), is it NOW or NOT allowed ?
    #### Going with NOT allowed as the Output seems to say the same
   values.remove_not_allowed_values!
   gift_values = get_gift_value(values)
   process(values)
   
   gifts = []
   sum = 0
   values.each do |v|
     gift_name = gift_values.key(v)
     if v > key || sum + gift_values[gift_name] > key 
       next
     else
       sum += gift_values[gift_name]
     end
     gifts.push(gift_name) if sum <= key
     break if sum >= key
   end
   gifts
  end
   
  def process(values)
    values.sort! { |x, y| @gifts[y].value <=> @gifts[x].value }
    values.map! {|x| @gifts[x].value }
  end

  def get_gift_value(values)
    temp = {}
    values.each { |x| temp[x] = @gifts[x].value }
    temp
  end

end

class Array
  def remove_not_allowed_values!
   self.map! {|x| x unless x.start_with?("!") }.compact!
  end
end
