require "gls_agent/version"
require 'gls_agent/gls_mech'
require 'gls_agent/dotfile'

module GLSAgent
  # GLS webpage reports something is bad.
  class GLSEndpointError < StandardError; end

  ParcelJob = Struct.new(:date, :name, :company, :street, :streetno, :zip, :city, :weight)

  def self.job_from_csv string
    fields = string.split(',')
    if fields.length != 8
      fail 'job_from_csv needs 8 fields'
      return nil
    end
    ParcelJob.new(*fields)
  end

  def self.job_from_hash hash
    ParcelJob.new(hash[:date],
                  hash[:name],
                  hash[:company],
                  hash[:street],
                  hash[:streetno],
                  hash[:zip],
                  hash[:city],
                  hash[:weight])
  end
end
