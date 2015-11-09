class Project < ActiveRecord::Base
  has_many :branches

  before_create :set_repo_name

  def repo_names
    branches.map {|b| b.repo_name }
  end

  def set_repo_name
    repo_name = name
  end

  def repo_name=(name)
    write_attribute(:repo_name, name.parameterize)
  end
end
