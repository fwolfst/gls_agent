module GLSAgent
  def self.get_dotfile_opts
    options = {}
    # Get defaults from ~/.gls_agent
    begin
      filecontent = File.open("#{Dir.home}/.gls_agent").read
      # from option=value\noption2=value2 make {'option':'value','option2':'value2'}
      filecontent.gsub!(/ *= */, ':')
      filecontent.gsub!(/(\w+)/, '"\1"')
      filecontent.gsub!("\n", ",\n")
      filecontent.chomp!("\n")
      filecontent.chomp!(',')
      filecontent = "{ #{filecontent} }"
      begin
        j_options = JSON.parse filecontent
        j_options.each {|o,v| options[o.to_sym] = v}
        puts "Info: read configuration parameters from ~/.gls_agent, may be overriden with cmd line options."
      rescue
        STDERR.puts "Error: configuration file in ~/.gls_agent found but could not be parsed."
        STDERR.puts $!.inspect,$@
      end
    rescue
      STDERR.puts "Info: No configuration file in ~/.gls_agent found, all options need to be specified on command line."
    end
    options
  end  
end
