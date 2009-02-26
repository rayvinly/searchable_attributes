require File.dirname(__FILE__) + '/../../../../spec/spec_helper'

plugin_spec_dir = File.dirname(__FILE__)
ActiveRecord::Base.logger = Logger.new(plugin_spec_dir + "/debug.log")

class SearchableUser < ActiveRecord::Base
  searchable_attributes :exact => [ :first_name, :last_name ], :like => [ :address, :city ]
  searchable_attributes :exact => :middle_name, :like => :state
end