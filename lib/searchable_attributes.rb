module SearchableAttributes

  def searchable_attributes(options = {})
    extend ClassMethods unless (class << self; included_modules; end).include?(ClassMethods)
    include InstanceMethods unless included_modules.include?(InstanceMethods)

    options[:exact].to_a.each do |attribute|
      self.named_scope "with_#{attribute}".to_sym, lambda { |a| { :conditions => { attribute => a } } }
    end

    options[:like].to_a.each do |attribute|
      self.named_scope "with_#{attribute}_like".to_sym, lambda { |a| { :conditions => (["#{attribute} like ?", "%#{a}%"] unless a.blank?) } }
    end
  end

  module ClassMethods
    def self.extended(base)
    end
  end

  module InstanceMethods
    def self.included(base)
    end

    protected

  end  
end
