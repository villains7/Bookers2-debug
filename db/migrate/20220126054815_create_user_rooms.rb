class CreateUserRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :user_rooms do |t|
      t.string :user_id
      t.string :room_id
      t.timestamps
    end
  end
end
