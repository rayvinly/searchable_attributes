module SearchableAttributes
  def searchable_attributes(options = {})
    self.columns.each do |column|
      case column.type
      when :integer, :float, :decimal, :datetime, :date, :time
        self.named_scope "with_#{column.name}_equal".to_sym, lambda { |value| { :conditions => { column.name => value } } }
        self.named_scope "with_#{column.name}_equal_if_not_null".to_sym, lambda { |value| { :conditions => ([ "#{column.name} = ?", value ] unless value.blank?) } }
        self.named_scope "with_#{column.name}_within_inclusive".to_sym, lambda { |range| { :conditions => ([ "#{column.name} >= ? AND #{column.name} <= ?", range.begin, range.end ] unless range.blank?) } }
        self.named_scope "with_#{column.name}_within_exclusive".to_sym, lambda { |range| { :conditions => ([ "#{column.name} > ? AND #{column.name} < ?", range.begin, range.end ] unless range.blank?) } }
        self.named_scope "with_#{column.name}_greater_than".to_sym, lambda { |value| { :conditions => ([ "#{column.name} > ?", value ] unless value.blank?) } }
        self.named_scope "with_#{column.name}_smaller_than".to_sym, lambda { |value| { :conditions => ([ "#{column.name} < ?", value ] unless value.blank?) } }
        self.named_scope "with_#{column.name}_greater_than_or_equal_to".to_sym, lambda { |value| { :conditions => ([ "#{column.name} >= ?", value ] unless value.blank?) } }
        self.named_scope "with_#{column.name}_smaller_than_or_equal_to".to_sym, lambda { |value| { :conditions => ([ "#{column.name} <= ?", value ] unless value.blank?) } }
      when :string, :text
        self.named_scope "with_#{column.name}_equal".to_sym, lambda { |value| { :conditions => { column.name => value } } }
        self.named_scope "with_#{column.name}_equal_if_not_null".to_sym, lambda { |value| { :conditions => ([ "#{column.name} = ?", value ] unless value.blank?) } }
        self.named_scope "with_#{column.name}_like".to_sym, lambda { |value| { :conditions => ([ "#{column.name} like ?", "%#{value}%" ] unless value.blank?) } }
        self.named_scope "with_#{column.name}_start_with".to_sym, lambda { |value| { :conditions => ([ "#{column.name} like ?", "#{value}%" ] unless value.blank?) } }
        self.named_scope "with_#{column.name}_end_with".to_sym, lambda { |value| { :conditions => ([ "#{column.name} like ?", "%#{value}" ] unless value.blank?) } }
      when :boolean
        self.named_scope "with_#{column.name}_equal".to_sym, lambda { |value| { :conditions => [ "#{column.name} = ?", value ] } }
        self.named_scope "with_#{column.name}_equal_if_not_null".to_sym, lambda { |value| { :conditions => ([ "#{column.name} = ?", value ] unless value.blank?) } }
      end
    end
  end
end
