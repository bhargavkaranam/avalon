class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.integer :uid	
      t.string :url
      t.timestamps
    end
  end
end
