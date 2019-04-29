# frozen_string_literal: true

module Content
  # path connecting to content.yml
  class ContentStore
    @path = 'config/content.yml'
    @content = false

    class << self
      attr_reader :path
    end

    class << self
      attr_writer :path
    end

    def self.content
      return YAML.load_file(path) if ENV.fetch('RAILS_ENV') == 'development'

      @content ||= begin
        YAML.load_file(@path)
      end
    end
  end
end
