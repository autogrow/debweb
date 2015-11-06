class Package < ActiveRecord::Base
  belongs_to :branch
  belongs_to :debfile
  
  def version; debfile.version; end
  def name;    debfile.version.sub(/\.deb$/, ''); end
  def control; debfile.control; end
end
