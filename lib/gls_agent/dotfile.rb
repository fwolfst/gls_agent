module GLSAgent
  module Dotfile
    # Get keys and values from file in ~/.gls_agent and put them in a hash.
    # keys are symbols.
    # The file should follow the syntax
    #     option=value
    #     option2=value2
    # Meaningful keys are i.e. user and pass.
    def self.get_opts
      options = {}
      # Get defaults from ~/.gls_agent
      begin
        filecontent = File.open("#{Dir.home}/.gls_agent").read
        options = hash_from_text filecontent
        puts "Info: read configuration parameters from ~/.gls_agent, may be overriden with cmd line options."
      rescue
        STDERR.puts "Info: No configuration file in ~/.gls_agent found, all options need to be specified on command line."
        #STDERR.puts $!.inspect,$@
      end
      options
    end  

    def self.hash_from_text text
      hash = {}
      text.each_line do |line|
        fields = line.split('=')
        fields.each &:strip!
        fields.each &:rstrip!
        hash[fields[0].to_sym] = fields[1]
      end
      hash
    end
  end
end
