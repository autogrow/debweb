module BranchesHelper
 
 def branch_link(branch)
   return 'none' unless branch
   link_to branch.name, branch
 end

end
