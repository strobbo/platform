class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.belongs_to :user
      t.belongs_to :city
      t.string :name
      t.date :date
      t.time :time
      t.text :description
      t.integer :user_id
      t.integer :city_id

      t.timestamps
    end
  end
end
