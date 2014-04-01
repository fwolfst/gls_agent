require "gls_agent/version"
require 'gls_agent/gls_mech'

module GLSAgent
  ParcelJob = Struct.new(:name, :street, :streetno, :zip, :city, :weight)
end
