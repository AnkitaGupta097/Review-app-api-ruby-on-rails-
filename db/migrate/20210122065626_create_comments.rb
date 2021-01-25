class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.integer :likes
      t.integer :dislikes
      t.string :reply
      t.belongs_to :post
      t.timestamps
    end
  end
end
