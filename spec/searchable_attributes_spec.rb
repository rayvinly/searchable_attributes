require File.dirname(__FILE__) + '/spec_helper'

load(File.dirname(__FILE__) + '/schema.rb')

describe SearchableAttributes do

  fixtures = YAML.load_file(File.dirname(__FILE__) + '/fixtures/searchable_users.yml')
  fixtures.each do |fixture|
    SearchableUser.create(fixture[1].symbolize_keys)
  end

  it "should define named_scope for string attributes" do
    SearchableUser.methods.include?('with_first_name_equal').should be_true
    SearchableUser.methods.include?('with_first_name_equal_if_not_null').should be_true
    SearchableUser.methods.include?('with_first_name_like').should be_true
    SearchableUser.methods.include?('with_first_name_start_with').should be_true
    SearchableUser.methods.include?('with_first_name_end_with').should be_true
  end

  it "should define named_scope for boolean attributes" do
    SearchableUser.methods.include?('with_injured_equal').should be_true
    SearchableUser.methods.include?('with_injured_equal_if_not_null').should be_true
  end

  it "should define named_scope for integer attributes" do
    SearchableUser.methods.include?('with_age_equal').should be_true
    SearchableUser.methods.include?('with_age_equal_if_not_null').should be_true
    SearchableUser.methods.include?('with_age_within_inclusive').should be_true
    SearchableUser.methods.include?('with_age_within_exclusive').should be_true
    SearchableUser.methods.include?('with_age_greater_than').should be_true
    SearchableUser.methods.include?('with_age_smaller_than').should be_true
    SearchableUser.methods.include?('with_age_greater_than_or_equal_to').should be_true
    SearchableUser.methods.include?('with_age_smaller_than_or_equal_to').should be_true
  end

  it "should define named_scope for decimal attributes" do
    SearchableUser.methods.include?('with_salary_equal').should be_true
    SearchableUser.methods.include?('with_salary_equal_if_not_null').should be_true
    SearchableUser.methods.include?('with_salary_within_inclusive').should be_true
    SearchableUser.methods.include?('with_salary_within_exclusive').should be_true
    SearchableUser.methods.include?('with_salary_greater_than').should be_true
    SearchableUser.methods.include?('with_salary_smaller_than').should be_true
    SearchableUser.methods.include?('with_salary_greater_than_or_equal_to').should be_true
    SearchableUser.methods.include?('with_salary_smaller_than_or_equal_to').should be_true
  end

  it "should define named_scope for datetime attributes" do
    SearchableUser.methods.include?('with_join_on_equal').should be_true
    SearchableUser.methods.include?('with_join_on_equal_if_not_null').should be_true
    SearchableUser.methods.include?('with_join_on_within_inclusive').should be_true
    SearchableUser.methods.include?('with_join_on_within_exclusive').should be_true
    SearchableUser.methods.include?('with_join_on_greater_than').should be_true
    SearchableUser.methods.include?('with_join_on_smaller_than').should be_true
    SearchableUser.methods.include?('with_join_on_greater_than_or_equal_to').should be_true
    SearchableUser.methods.include?('with_join_on_smaller_than_or_equal_to').should be_true
  end

  it "should find records for string attributes" do
    SearchableUser.with_first_name_equal('Gilbert').count.should > 0
    SearchableUser.with_first_name_equal('Gilbert').each { |searchable_user| searchable_user.first_name.should == 'Gilbert' }

    SearchableUser.with_first_name_equal_if_not_null('Gilbert').count.should > 0
    SearchableUser.with_first_name_equal_if_not_null('Gilbert').each { |searchable_user| searchable_user.first_name.should == 'Gilbert' }

    SearchableUser.with_first_name_equal_if_not_null(nil).count.should > 0
    SearchableUser.with_first_name_equal_if_not_null(nil).count.should == SearchableUser.count

    SearchableUser.with_first_name_like('ilbe').count.should > 0
    SearchableUser.with_first_name_like('ilbe').each { |searchable_user| searchable_user.first_name.include?('ilbe') }

    SearchableUser.with_position_start_with('P').count.should > 0
    SearchableUser.with_position_start_with('P').each { |searchable_user| searchable_user.position.should =~ /^P/ }

    SearchableUser.with_position_end_with('Forward').count.should > 0
    SearchableUser.with_position_end_with('Forward').each { |searchable_user| searchable_user.position.should =~ /Forward$/ }
  end

  it "should find records for boolean attributes" do
    SearchableUser.with_injured_equal(true).count.should > 0
    SearchableUser.with_injured_equal(true).each { |searchable_user| searchable_user.injured.should be_true }

    SearchableUser.with_injured_equal(false).count.should > 0
    SearchableUser.with_injured_equal(false).each { |searchable_user| searchable_user.injured.should be_false }
  end

  it "should find records for integer attributes" do
    SearchableUser.with_age_equal(26).count.should > 0
    SearchableUser.with_age_equal(26).each { |searchable_user| searchable_user.age.should == 26 }

    SearchableUser.with_age_equal_if_not_null(26).count.should > 0
    SearchableUser.with_age_equal_if_not_null(26).each { |searchable_user| searchable_user.age.should == 26 }

    SearchableUser.with_age_equal_if_not_null(nil).count.should > 0
    SearchableUser.with_age_equal_if_not_null(nil).count.should == SearchableUser.count

    SearchableUser.with_age_within_inclusive((26..30)).count.should > 0
    SearchableUser.with_age_within_inclusive((26..30)).each { |searchable_user| (26..30).include?(searchable_user.age).should be_true }

    SearchableUser.with_age_within_exclusive((26..30)).count.should > 0
    SearchableUser.with_age_within_exclusive((26..30)).each { |searchable_user| (26..30).include?(searchable_user.age).should be_true }

    SearchableUser.with_age_greater_than(28).count.should > 0
    SearchableUser.with_age_greater_than(28).each { |searchable_user| searchable_user.age.should > 28 }

    SearchableUser.with_age_smaller_than(28).count.should > 0
    SearchableUser.with_age_smaller_than(28).each { |searchable_user| searchable_user.age.should < 28 }

    SearchableUser.with_age_greater_than_or_equal_to(28).count.should > 0
    SearchableUser.with_age_greater_than_or_equal_to(28).each { |searchable_user| searchable_user.age.should >= 28 }

    SearchableUser.with_age_smaller_than_or_equal_to(28).count.should > 0
    SearchableUser.with_age_smaller_than_or_equal_to(28).each { |searchable_user| searchable_user.age.should <= 28 }
  end

  it "should find records for decimal attributes" do
    SearchableUser.with_salary_equal(33333.33).count.should > 0
    SearchableUser.with_salary_equal(33333.33).each { |searchable_user| searchable_user.salary.should == 33333.33 }

    SearchableUser.with_salary_equal_if_not_null(33333.33).count.should > 0
    SearchableUser.with_salary_equal_if_not_null(33333.33).each { |searchable_user| searchable_user.salary.should == 33333.33 }

    SearchableUser.with_salary_equal_if_not_null(nil).count.should > 0
    SearchableUser.with_salary_equal_if_not_null(nil).count.should == SearchableUser.count

    SearchableUser.with_salary_within_inclusive((33333.33..99999.99)).count.should > 0
    SearchableUser.with_salary_within_inclusive((33333.33..99999.99)).each { |searchable_user| (33333.33..99999.99).include?(searchable_user.salary).should be_true }

    SearchableUser.with_salary_within_exclusive((33333.33..99999.99)).count.should > 0
    SearchableUser.with_salary_within_exclusive((33333.33..99999.99)).each { |searchable_user| (33333.33..99999.99).include?(searchable_user.salary).should be_true }

    SearchableUser.with_salary_greater_than(25000).count.should > 0
    SearchableUser.with_salary_greater_than(25000).each { |searchable_user| searchable_user.salary.should > 25000 }

    SearchableUser.with_salary_smaller_than(75000).count.should > 0
    SearchableUser.with_salary_smaller_than(75000).each { |searchable_user| searchable_user.salary.should < 75000 }

    SearchableUser.with_salary_greater_than_or_equal_to(66666.66).count.should > 0
    SearchableUser.with_salary_greater_than_or_equal_to(66666.66).each { |searchable_user| searchable_user.salary.should >= 66666.66 }

    SearchableUser.with_salary_smaller_than_or_equal_to(66666.66).count.should > 0
    SearchableUser.with_salary_smaller_than_or_equal_to(66666.66).each { |searchable_user| searchable_user.salary.should <= 66666.66 }
  end

  it "should find records for date attributes" do
    SearchableUser.with_join_on_equal('2006-02-27'.to_date).count.should > 0
    SearchableUser.with_join_on_equal('2006-02-27'.to_date).each { |searchable_user| searchable_user.join_on.should == 3.years.ago.to_date }

    SearchableUser.with_join_on_equal_if_not_null('2006-02-27'.to_date).count.should > 0
    SearchableUser.with_join_on_equal_if_not_null('2006-02-27'.to_date).each { |searchable_user| searchable_user.join_on.should == 3.years.ago.to_date }

    SearchableUser.with_join_on_equal_if_not_null(nil).count.should > 0
    SearchableUser.with_join_on_equal_if_not_null(nil).count.should == SearchableUser.count

    SearchableUser.with_join_on_within_inclusive(('2004-02-27'.to_date..'2006-02-27'.to_date)).count.should > 0
    SearchableUser.with_join_on_within_inclusive(('2004-02-27'.to_date..'2006-02-27'.to_date)).each { |searchable_user| ('2004-02-27'.to_date..'2006-02-27'.to_date).include?(searchable_user.join_on).should be_true }

    SearchableUser.with_join_on_within_exclusive(('2003-02-27'.to_date..'2006-02-27'.to_date)).count.should > 0
    SearchableUser.with_join_on_within_exclusive(('2003-02-27'.to_date..'2006-02-27'.to_date)).each { |searchable_user| ('2003-02-27'.to_date..'2006-02-27'.to_date).include?(searchable_user.join_on).should be_true }

    SearchableUser.with_join_on_greater_than('2004-02-27'.to_date).count.should > 0
    SearchableUser.with_join_on_greater_than('2004-02-27'.to_date).each { |searchable_user| searchable_user.join_on.should > '2004-02-27'.to_date }

    SearchableUser.with_join_on_smaller_than('2006-02-27'.to_date).count.should > 0
    SearchableUser.with_join_on_smaller_than('2006-02-27'.to_date).each { |searchable_user| searchable_user.join_on.should < '2006-02-27'.to_date }

    SearchableUser.with_join_on_greater_than_or_equal_to('2006-02-27'.to_date).count.should > 0
    SearchableUser.with_join_on_greater_than_or_equal_to('2006-02-27'.to_date).each { |searchable_user| searchable_user.join_on.should >= '2006-02-27'.to_date }

    SearchableUser.with_join_on_smaller_than_or_equal_to('2006-02-27'.to_date).count.should > 0
    SearchableUser.with_join_on_smaller_than_or_equal_to('2006-02-27'.to_date).each { |searchable_user| searchable_user.join_on.should <= '2006-02-27'.to_date }
  end
end
