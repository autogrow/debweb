module Services
  class AutoPackageAdd
    def initialize(debfiles)
      @debfiles = debfiles
    end

    def process
      Branch.all.each do |b|
        @debfiles.each do |deb|
          if b.auto_added_packages.include?(deb)
            PackageAssignment.new(b).process([deb.id])
          end
        end
      end
    end
  end
end