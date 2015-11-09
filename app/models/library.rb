class Library

  attr_reader :path

  def initialize
    @path = File.expand_path("./library")  #Settings.get("library_path")
    @size = nil
  end

  def files
    Dir["#{@path}/*.deb"]
  end
  
  def size
    @size ||= measure_size  # $redis.get("library:size") || $redis.setex("library:size", 120, get_size)
  end

  def measure_size
    bytes  = `du -sb #{@path}`.chomp.split.first.to_i
    mbytes = (bytes / 1024 / 1024).round
    "#{mbytes}MB"
  end
end
