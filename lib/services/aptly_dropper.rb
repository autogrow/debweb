module Services
  class AptlyDropper
    def initialize(project, log)
      @project = project
      @log     = log
    end

    def process
      @log.warn "Dropping distribution #{@project.distrib_name}..."
      Aptly::PublishedResource.new(@project.distrib_name).drop
      @project.repos.each do |name|
        @log.warn "Dropping repo #{name}..."
        Aptly::Repo(name).drop
      end
    end
  end
end