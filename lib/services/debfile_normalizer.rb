module Services
  class DebfileNormalizer
  
    def initialize(debfile)
      @debfile = debfile
    end
    
    def process
      return true if @debfile.name == normalized_name
      rename! and @debfile.exist?
    end

    def normalized_name
      ctrl = @debfile.control
      "#{ctrl["Package"]}_#{ctrl["Version"]}_#{ctrl["Architecture"]}.deb"
    end
    
    def rename!
      new_name = normalized_name
      new_path = "#{@debfile.path}/#{new_name}"
      FileUtils.mv @debfile.filepath, new_path
      @debfile.name = new_name
      @debfile.save
    end
  end
end
