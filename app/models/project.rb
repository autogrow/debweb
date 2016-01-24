class Project < ActiveRecord::Base
  has_many :branches

  def repo_names
    branches.map {|b| b.repo_name }
  end

  def name=(val)
    super(val)
    self.distribution_name = val.parameterize
  end

  def components
    branches.map {|b| b.component_name }
  end

  def repos
    branches.map {|b| b.repo_name }
  end

end
