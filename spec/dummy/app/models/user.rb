class User

  attr_accessor :first_name, :last_name, :email

  def initialize(options={})
    @first_name  = options[:first_name]
    @last_name   = options[:last_name]
    @email       = options[:email]
  end

end