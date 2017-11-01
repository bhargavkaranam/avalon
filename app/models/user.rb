class User < ApplicationRecord
	def change
    create_table :users do |t|
      t.string :email
      t.string :password
 	  t.string :name
 	  t.integer :age
      t.timestamps
    end
  end
end
