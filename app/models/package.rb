class Package < ActiveRecord::Base
  belongs_to :branch
  belongs_to :debfile
  
  def version; debfile.control["Version"]; end
  def name; debfile.control["Package"]; end
  def control; debfile.control; end
end
