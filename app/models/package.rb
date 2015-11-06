class Package < ActiveRecord::Base
  belongs_to :branch
  belongs_to :debfile
  
  def version; debfile.version; end
  def name;    debfile.version; end
  def control; debfile.control; end
end
