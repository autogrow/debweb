class Branch < ActiveRecord::Base
  belongs_to :project
  has_many :packages

  before_create :set_repo_name

  def set_repo_name
    repo_name = name
  end

  def repo_name=(name)
    write_attribute(:repo_name, name.parameterize)
  end

end
