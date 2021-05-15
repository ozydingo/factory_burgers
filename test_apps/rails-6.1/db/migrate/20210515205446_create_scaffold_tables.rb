class CreateScaffoldTables < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.timestamps
      t.string :type
      t.string :firstname
      t.string :lastname
      t.string :login, unique: true
      t.string :email, unqiue: true
    end

    create_table :posts do |t|
      t.timestamps
      t.references :author
      t.string :title
      t.text :body
    end

    create_table :comments do |t|
      t.timestamps
      t.references :post
      t.references :author
      t.text :body
    end
  end
end
