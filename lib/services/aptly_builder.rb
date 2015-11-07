module Services
  class AptlyBuilder
    attr_reader :errors
  
    def initialize(project)
      @project = project
      @errors  = []
    end
    
    def process
      create_repos
      add_packages
      publish_repos
    end
    
    def create_repos
      repos = Aptly.list_repos
      @project.branches.each do |b|
        next if repos.include? b.repo_name
        
        begin
          Aptly.create_repo b.repo_name, dist: @project.name.downcase
        rescue AptlyError => e
          @errors << e.message
        end
      end
    end
    
    def add_packages
      @project.branches.each do |b|
        repo = Aptly::Repo.new b.repo_name
        packages = repo.list_packages
        b.packages.each do |p|
          next if packages.include? p.debfile.name.sub(/\.deb$/, '')
          begin
            repo.add p.debfile.filepath
          rescue AptlyError => e
            @errors << e.message
          end
        end
      end
    end
    
    def publish_repos
      @project.repos.each do |name|
        repo = Aptly::Repo.new name
        begin
          repo.publish sign: false
        rescue AptlyError
          system "aptly publish update #{@project.name.downcase}"
        end
      end
    end
  
  end
end
