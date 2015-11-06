require 'debian_control_parser'

class Debfile < ActiveRecord::Base
  serialize :control, Hash

  has_many :packages

  before_create :read_control_file

  def path
    "#{@path}/#{@name}"
  end

  def read_control_file
    path     = "#{@path}/#{@name}"
    data     = `dpkg-deb -I #{path}`.chomp
    @control = {}
    
    ::DebianControlParser.new(data).paragraphs do |p|
      p.fields do |field, value|
        @control[field] = value
      end
    end
  end

    
end
