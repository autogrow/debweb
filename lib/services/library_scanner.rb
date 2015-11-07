module Services
  class LibraryScanner
    attr_reader :created
  
    def initialize(library)
      @library = library
      @created = []
    end
  
    def process
      @library.files.map {|f| File.basename(f) }.each do |fn|
        next if Debfile.find_by_name fn
        @created << Debfile.create(name: fn, path: @library.path)
        Services::DebfileNormalizer.new(@created.last).process
      end
    end
  
  end
end
