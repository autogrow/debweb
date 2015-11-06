module Services
  class LibraryScanner
  
    def initialize(library)
      @library = library
    end
  
    def process
      @library.files.map {|f| File.basename(f) }.each do |fn|
        next if Debfile.find_by_name fn
        Debfile.create(name: fn, path: @library.path)
      end
    end
  
  end
end
