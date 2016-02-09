module PackagesHelper
  def auto_add_package_label(package)
    icon, klass = *(package.branch.auto_added?(package.name) ? ['ok-circle', 'success'] : ['ban-circle', 'default'])
    raw link_to(glyph(icon), '#', class: "btn btn-sm btn-#{klass}")
    #auto_add_package_branch_path(package_id: package.id)
  end
end
