class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :name
      t.string :language
      t.integer :page_count
      t.integer :author_ids, array: true
      t.integer :genre_ids, array: true

      t.timestamps
    end
  end
end
