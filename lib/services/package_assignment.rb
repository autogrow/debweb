module Services
  class PackageAssignment
    def initialize(branch)
      @branch = branch
    end
    
    def process(debfile_ids)
      Services::LibraryScanner.new(Library.new).process
      dupes = 0
      saved = 0
      debfile_ids.each do |id|
        
        debfile = Debfile.find(id)
        dupes+=1 and next if Package.find_by_branch_id_and_debfile_id(@branch.id, debfile.id)
        
        begin
          Package.create(
            branch: @branch,
            debfile: debfile
          )
          saved+=1
        rescue => e
        end
      end
      
      failed = debfile_ids.size - saved
      
      return case
      when (dupes.zero? and saved.zero? and failed.zero?)
        {warning: "Nothing was done"}
      when saved == debfile_ids.size
        {success: "Added #{saved} packages to #{@branch.name}"}
      when dupes > 0
        {success: "Added #{saved} packages, #{dupes} were already added"}
      when (failed > 0 and success.zero? and dupes.zero?)
        {error: "Failed to add every package" }
      when (failed > 0 and success > 0)
        {warning: "Added #{success} but #{failed} failed"}
      end
    end
  end
end
