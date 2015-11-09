module Services
  class AptlyBuilder
    attr_reader :errors
  
    def initialize(project, log)
      @project = project
      @errors  = []
      @log     = log
    end
    
    def process
      @log.info "Building aptly structure for #{@project.name}"
      create_repos
      add_packages
      publish_repos
    end
    
    def create_repos
      @log.info "Creating repos..."
      repos = Aptly.list_repos
      @project.branches.each do |b|
        next if repos.include? b.repo_name
        @log.info "Need to create #{b.repo_name}"
        
        begin
          Aptly.create_repo b.repo_name, dist: @project.repo_name, component: b.repo_name
          @log.info "Repo #{b.repo_name} was created"
        rescue AptlyError => e
          @log.error e
          @errors << e.message
        end
      end
    end
    
    def add_packages
      @project.branches.each do |b|
        @log.info "Adding #{b.packages.size} packages to #{b.repo_name}"
        repo = Aptly::Repo.new b.repo_name
        packages = repo.list_packages
        @log.info "#{packages.size} already in #{b.repo_name}"
        b.packages.each do |p|
          next if packages.include? p.debfile.name.sub(/\.deb$/, '')
          begin
            repo.add p.debfile.filepath
            @log.info "Added package #{p.debfile.name}"
          rescue AptlyError => e
            @log.error e
            @errors << e.message
          end
        end
      end
    end
    
    def publish_repos
      @project.branches.each do |b|
        name = b.repo_name
        repo = Aptly::Repo.new name
        begin
          repo.publish sign: false, component: b.repo_name
          @log.info "Published repo #{name} for the first time"
        rescue AptlyError
          system "aptly publish update #{@project.repo_name}"
          if $?.success?
            @log.info "Updated published packages for #{name}"
          else
            @log.error "Failed to update published packages for #{name}"
          end
        end
      end
    end
  
  end
end
