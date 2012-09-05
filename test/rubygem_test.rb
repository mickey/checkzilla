require 'test_helper'

describe "detect Gemfile.lock files" do

  before do
    @rubygem = Updates::Check::Rubygem.new
    @rubygem.path = "#{File.expand_path(File.dirname(__FILE__))}/../test/fixtures"
  end

  it "detects a Gemfile.lock" do
    assert_equal true, @rubygem.send(:gemfilelock_exists?)
  end

  it "shouldnt detect anything" do
    @rubygem.path = "#{File.expand_path(File.dirname(__FILE__))}/../lib/updates"
    assert_equal false, @rubygem.send(:gemfilelock_exists?)
  end

end

describe "Parse and extracts dependencies" do

  before do
    @rubygem = Updates::Check::Rubygem.new
    @rubygem.path = "#{File.expand_path(File.dirname(__FILE__))}/../test/fixtures"
  end

  it "parses Gemfile.lock and extracts dependencies" do
    deps = @rubygem.send(:deps_from_gemfilelock)
    assert_equal false, deps.empty?
    # check a few ones
    assert_equal "0.0.3", deps["rails_admin"]
    assert_equal "3.12", deps["rdoc"]
    assert_equal "3.2.6", deps["rails"]
  end

end