require 'spec_helper'

describe Project do
  let(:project) { Project.create(name: "TEST") }

  it "should have a distribution name" do
    expect(project.distribution_name).to eq "test"
    expect(project.distribution_name).to eq project.distribution # alias
  end

end