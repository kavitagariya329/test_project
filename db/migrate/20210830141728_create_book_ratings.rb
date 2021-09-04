class CreateBookRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :book_ratings do |t|
      t.string :text
      t.integer :stars, :limit => 1
      t.integer :book_id
      t.timestamps
    end
  end
end
