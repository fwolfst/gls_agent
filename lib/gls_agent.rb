require "gls_agent/version"
require 'gls_agent/gls_mech'
require 'gls_agent/dotfile'

module GLSAgent
  ParcelJob = Struct.new(:name, :street, :streetno, :zip, :city, :weight)

  def self.job_from_csv string
    fields = string.split(',')
    if fields.length != 6
      fail 'job_from_csv needs 6 fields'
      return nil
    end
    ParcelJob.new(*fields)
  end

  def self.job_from_hash hash
    ParcelJob.new(hash[:name], hash[:street], hash[:streetno], hash[:zip], hash[:city], hash[:weight])
  end
end
