class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :contents
      t.string :author

      t.timestamps
    end
  end
end
