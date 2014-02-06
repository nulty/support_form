module SupportForm
  class Enquiry
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend  ActiveModel::Naming

    attr_accessor :name, :email, :message, :stats_id, :topic

    validates :name, :email, :message, presence: true

    def initialize(options={})
      @name = options[:name]
      @email = options[:email]
      @message = options[:message]
      @stats_id = options[:stats_id]
      @topic = options[:topic]
    end

    def persisted?
      false
    end
  end
end
