class TodoTimer::Configuration
  class << self
    attr_accessor :paperclip_options
  end
end


TodoTimer::Configuration.paperclip_options = YAML.load(ERB.new(File.read(Rails.root.join('config', 'paperclip_options.yml'))).result)[Rails.env]
Paperclip::Attachment.default_options[:use_timestamp] = false