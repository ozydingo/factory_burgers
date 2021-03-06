ActiveRecord::Schema.define(version: 1) do
  create_table :users do |t|
    t.string    :type
    t.string    :login
    t.string    :email
    t.string    :name
    t.integer   :group_id
  end

  create_table :profiles do |t|
    t.integer :user_id
    t.string :spirit_animal
  end

  create_table :posts do |t|
    t.integer :author_id
    t.text :body
  end

  create_table :stars do |t|
    t.integer :post_id
  end

  create_table :groups do |t|
    t.string :name
  end
end
