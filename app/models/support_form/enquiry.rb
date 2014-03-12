module SupportForm
  class Enquiry
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend  ActiveModel::Naming

    attr_accessor :name, :email, :message, :stats_id, :topic

    validates :name, :email, :message, :stats_id, :topic, presence: true
    validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
    validates :stats_id, inclusion: { :in => proc {SupportForm::Stat.pluck(:id).map(&:to_s)} }
    validates :topic, inclusion: {:in=>proc { |o| o.stats.categories.keys }}, if: proc { |o| o.stats.present? }

    def initialize(options={})
      @name = options[:name]
      @email = options[:email]
      @message = options[:message]
      @stats_id = options[:stats_id]
      @topic = options[:topic]
    end

    def stats
      SupportForm::Stat.find(stats_id) if stats_id.present?
    end

    def persisted?
      false
    end
  end
end
