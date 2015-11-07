module ProjectsHelper

  def project_link(project)
    return 'none' if project.nil?
    link_to project.name, project
  end
end
