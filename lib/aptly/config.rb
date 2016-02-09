module Aptly
  module Config
    extend self
    FILE = ENV["HOME"]+"/.aptly.conf"

    def open(file)
      JSON.parse(File.read(FILE))
    end

  end
end