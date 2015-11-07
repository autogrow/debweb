class Project < ActiveRecord::Base
  has_many :branches

  def repos
    branches.map {|b| b.repo_name }
  end
end
