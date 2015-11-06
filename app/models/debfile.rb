require 'debian_control_parser'

class Debfile < ActiveRecord::Base
  serialize :control, Hash

  has_many :packages

  #after_initialize :read_control_file
  before_create :read_control_file

  def filepath
    File.join(path, name)
  end

  def read_control_file
    data  = `dpkg-deb -I #{filepath}`.chomp
    hash = {}
    
    ::DebianControlParser.new(data).paragraphs do |p|
      p.fields do |field, value|
        hash["field"] = value
      end
    end
    
    write_attribute(:control,  hash)
  end

    
end
