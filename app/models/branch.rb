class Branch < ActiveRecord::Base

  serialize :auto_added_packages, Array

  belongs_to :project
  has_many :packages

  before_create :set_repo_name

  def set_repo_name
    repo_name = name
  end

  def repo_name=(name)
    write_attribute(:repo_name, name.parameterize)
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
