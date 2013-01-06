class Gift

  attr_accessor :name, :value

  def initialize(args)
    params = args.split
    build_gift(params)
  end


  private

  def build_gift(params)
    setup_name(params.first)
    setup_value(params.last.to_i)
  end

  def setup_name(name)
    begin
      if name && name.is_a?(String)
        @name = name
      else
        raise "Invalid name, please provide a string"
      end
    rescue Exception => e
      puts e.message
    end
  end

  def setup_value(value)
    begin
      if value && value.to_i > 0
        @value = value
      else
        raise "Invalid Value"
      end
    rescue Exception => e
      puts e.message
    end
  end




end
