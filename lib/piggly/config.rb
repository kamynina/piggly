module Piggly
  class Config

    def self.config_accessor(hash)
      hash.keys.each do |name|
        self.class.send(:define_method, name) do
          instance_variable_get("@#{name}") || hash[name]
        end
        self.class.send(:define_method, "#{name}=") do |value|
          instance_variable_set("@#{name}", value)
        end
      end
    end

    config_accessor :cache_root   => File.expand_path(File.join(Dir.pwd, 'piggly', 'cache')),
                    :report_root  => File.expand_path(File.join(Dir.pwd, 'piggly', 'reports')),
                    :piggly_root  => PIGGLY_ROOT,
                    :trace_prefix => 'PIGGLY',
                    :aggregate    => false

    def self.path(root, file=nil)
      if file
        file[%r{^\.\.|^\/|^(?:[A-Z]:)?/}i] ? file : File.join(root, file)
      else
        root
      end
    end

    def self.mkpath(root, file=nil)
      if file.nil?
        FileUtils.makedirs(root)
        root
      else
        path = path(root, file)
        FileUtils.makedirs(File.dirname(path))
        path
      end
    end

  end
end