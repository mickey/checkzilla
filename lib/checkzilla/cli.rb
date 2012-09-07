module CheckZilla
  class CLI  < Clamp::Command
    parameter "CONFIGURATION ...", "the configuration file", :attribute_name => :config_file

    def execute
      conf_relative_path = File::join(Dir.pwd, config_file)
      require conf_relative_path
    end

  end
end