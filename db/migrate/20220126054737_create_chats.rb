class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|
      t.string :user_id
      t.string :room_id
      t.text :message

      t.timestamps
    end
  end
end
