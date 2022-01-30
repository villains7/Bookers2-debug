class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.references :visitor, null: false, foreign_key: true
      t.references :visited, null: false, foreign_key: true
      t.references :book, null: true, foreign_key: true
      t.references :book_comment, null: true, foreign_key: true
      t.string :action
      t.boolean :checkd,default: false, null:false

      t.timestamps
    end
  end
end
