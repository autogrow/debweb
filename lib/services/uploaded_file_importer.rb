module Services
  class UploadedFileImporter
    def initialize(filepath, log)
      @filepath = filepath
      @log      = log
      @name     = File.basename(filepath)
    end

    def process(library, delete_after=true)
      begin
        ctrl = DebianFileScanner.scan(@filepath)
        @log.info "Scanned #{@name} and found #{ctrl['Package']} #{ctrl['Version']}"

        name = "#{ctrl["Package"]}_#{ctrl["Version"]}_#{ctrl["Architecture"]}.deb"

        raise ArgumentError, "package already exists in the library" if File.exist? library.path(name)

        FileUtils.mv @filepath, library.path(name)
        @log.info "Moved #{@filepath} to #{library.path(name)}"

        library.scan
        @log.info "Rescanned library"
      rescue ArgumentError => e
        @log.info "Failed to import #{@name}: #{e.message}"
        @log.error e
        return false
      ensure
        if delete_after
          FileUtils.rm @filepath if File.exists?(@filepath)
          @log.warn "Deleted #{@filepath}"
        end
      end

      true
    end
  end
end
