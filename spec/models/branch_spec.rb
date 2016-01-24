require 'spec_helper.rb'
require 'rails_helper.rb'

describe Branch do
  let(:project) { Project.create(name: "TEST") }
  let(:branch) { project.branches.new(name: "stable") }

  it "should have a name" do
    expect(branch.name).to eq "stable"
  end

  it "should have a component name if not saved with one" do
    branch.save
    branch.reload
    expect(branch.component_name).to eq "stable"
  end

  it "should have a repo name" do
    expect(branch.repo_name).to eq "TEST-stable"
  end

  it "should accept a different component name" do
    branch.component_name = "unstable"
    branch.save
    branch.reload

    expect(branch.component_name).to eq "unstable"
  end

end