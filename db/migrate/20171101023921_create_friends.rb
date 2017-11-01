class CreateFriends < ActiveRecord::Migration[5.1]
  def change
    create_table :friends do |t|

      t.integer :fid1	
      t.integer :fid2
      t.boolean :accepted
      t.timestamps
    end
  end
end
