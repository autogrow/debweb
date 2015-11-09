require 'debian_control_parser'

module DebianFileScanner
  extend self

  def scan(filepath)
    output = `dpkg-deb -I #{filepath}`.chomp
    raise ArgumentError, output unless $?.success?

    hash = {}
    
    ::DebianControlParser.new(output).paragraphs do |p|
      p.fields do |field, value|
        hash[field.strip!] = value
      end
    end

    hash
  end
end