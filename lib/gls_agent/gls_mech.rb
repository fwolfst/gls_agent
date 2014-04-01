require 'mechanize'
require 'logger'

class GLSMech
  attr_accessor :mech

  # Setup the mech.
  def initialize
    @mech = Mechanize.new
    @mech.user_agent_alias = 'Windows Mozilla'
  end

  # Enable logging to given file.
  def log_to filename
    @mech.log = Logger.new filename
  end
end
