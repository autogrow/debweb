class Branch < ActiveRecord::Base
  serialize :auto_added_packages, Array

  belongs_to :project
  has_many :packages

  def repo_name
    "#{project.name}-#{component_name}"
  end

  def name=(val)
    super(val)
    self.component_name ||= name.parameterize
  end

  def auto_add(package_name)
    auto_added_packages = (auto_added_packages || []).push(package_name) unless auto_added?(package_name)
  end

  def stop_auto_adding(package_name)
    auto_added_packages = auto_added_packages.delete(package_name)
  end

  def auto_added?(package_name)
    auto_added_packages.include?(package_name)
  end
end
