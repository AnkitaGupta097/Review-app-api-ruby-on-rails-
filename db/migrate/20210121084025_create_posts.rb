class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.belongs_to :user  
      t.belongs_to :reviewable,:polymorphic => true
      t.timestamps

    end
  end
end
