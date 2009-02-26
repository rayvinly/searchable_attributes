require File.dirname(__FILE__) + '/spec_helper'

load(File.dirname(__FILE__) + '/schema.rb')

describe SearchableAttributes do

  fixtures = YAML.load_file(File.dirname(__FILE__) + '/fixtures/searchable_users.yml')
  fixtures.each do |fixture|
    SearchableUser.create(fixture[1].symbolize_keys)
  end

  it "should define named_scope for a single exact attribute" do
    SearchableUser.methods.select { |method| method == 'with_middle_name' }.size.should == 1
    SearchableUser.methods.include?('with_middle_name').should be_true
  end

  it "should define named_scope for an array of exact attributes" do
    SearchableUser.methods.include?('with_first_name').should be_true
    SearchableUser.methods.include?('with_last_name').should be_true
  end

  it "should define named_scope for a single like attribute" do
    SearchableUser.methods.include?('with_state_like').should be_true
  end

  it "should define named_scope for an array of like attributes" do
    SearchableUser.methods.include?('with_address_like').should be_true
    SearchableUser.methods.include?('with_city_like').should be_true
  end

  it "should find records with exact searchable attributes" do
    SearchableUser.with_first_name('Gilbert').each { |searchable_user| searchable_user.first_name.should == 'Gilbert' }
    SearchableUser.with_middle_name('James').each { |searchable_user| searchable_user.middle_name.should == 'James' }
    SearchableUser.with_last_name('Butler').each { |searchable_user| searchable_user.last_name.should == 'Butler' }
  end

  it "should find records with like searchable attributes" do
    SearchableUser.with_address_like('Main').each { |searchable_user| searchable_user.address.include?('Main') }
    SearchableUser.with_city_like('Great').each { |searchable_user| searchable_user.address.include?('Great') }
    SearchableUser.with_state_like('Columbia').each { |searchable_user| searchable_user.address.include?('Columbia') }
  end
end