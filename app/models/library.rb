class Library

  attr_reader :path

  def initialize
    @path = "./library"  #Settings.get("library_path")
    @size = nil
  end

  def files
    Dir["#{@path}/*.deb"]
  end
  
  def size
    @size ||= measure_size  # $redis.get("library:size") || $redis.setex("library:size", 120, get_size)
  end

  def measure_size
    `du -sh #{@path}`.chomp.split.first
  end
end
