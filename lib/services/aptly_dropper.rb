module Services
  class AptlyDropper
    def initialize(project, log)
      @project = project
      @log     = log
    end

    def process
      @log.warn "Dropping distribution #{@project.distribution}..."
      
      begin
        Aptly::PublishedResource.new(@project.distribution).drop
      rescue => e # TODO: catch the right error
        @log.error(e)
      end
      
      @project.repos.each do |name|
        @log.warn "Dropping repo #{name}..."
        begin
          Aptly::Repo(name).drop
        rescue => e # TODO: catch the right error
          @log.error(e)
        end
      end
    end
  end
end
