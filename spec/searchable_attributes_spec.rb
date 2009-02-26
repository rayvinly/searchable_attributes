require File.dirname(__FILE__) + '/spec_helper'

load(File.dirname(__FILE__) + '/schema.rb')

describe SearchableAttributes do

  fixtures = YAML.load_file(File.dirname(__FILE__) + '/fixtures/searchable_users.yml')
  fixtures.each do |fixture|
    SearchableUser.create(fixture[1].symbolize_keys)
  end

  it "should define named_scope for a single exact attribute" do
    SearchableUser.methods.select { |method| method == 'with_middle_name' }.size.should == 1
  end

  it "should define named_scope for an array of exact attributes" do
    SearchableUser.methods.select { |method| method == 'with_first_name' }.size.should == 1
    SearchableUser.methods.select { |method| method == 'with_last_name' }.size.should == 1
  end

  it "should define named_scope for a single like attribute" do
    SearchableUser.methods.select { |method| method == 'with_state_like' }.size.should == 1
  end

  it "should define named_scope for an array of like attributes" do
    SearchableUser.methods.select { |method| method == 'with_address_like' }.size.should == 1
    SearchableUser.methods.select { |method| method == 'with_city_like' }.size.should == 1
  end

  it "should find records with exact searchable attributes" do
    SearchableUser.with_first_name('Gilbert').size.should == 1
    SearchableUser.with_middle_name('James').size.should == 1
    SearchableUser.with_last_name('Butler').size.should == 1
  end

  it "should find records with like searchable attributes" do
    SearchableUser.with_address_like('Main').size.should == 3
    SearchableUser.with_city_like('Great').size.should == 2
    SearchableUser.with_state_like('Columbia').size.should == 1
  end
end