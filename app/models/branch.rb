class Branch < ActiveRecord::Base
  belongs_to :project
  has_many :packages

  def repo_name
    "#{project.name.downcase}-#{name.downcase}"
  end
end
