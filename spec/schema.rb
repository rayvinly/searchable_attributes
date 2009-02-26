ActiveRecord::Schema.define :version => 0 do
  create_table :searchable_users, :force => true do |t|
    t.column :first_name, :string
    t.column :last_name, :string
    t.column :middle_name, :string
    t.column :address, :string
    t.column :city, :string
    t.column :state, :string
  end
end
