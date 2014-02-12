module SupportForm
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration) if block_given?
  end

  class Configuration
    attr_accessor :use_form_flash

    def initialize
      @use_form_flash = false
    end
  end

end