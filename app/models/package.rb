class Package < ActiveRecord::Base
  belongs_to :branch
  belongs_to :debfile

  before_create :copy_fields

  def version; debfile.control["Version"]; end
  def control; debfile.control; end

  def copy_fields
    write_attribute :name, debfile.package_name
    write_attribute :version, debfile.version
  end

  def other_versions
    self.where(branch_id: branch_id, name: name).order('version DESC')
  end
end
