class Comments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t| 
      t.string :content 
    end 
  end
end
