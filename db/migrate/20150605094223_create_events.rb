class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime   :date
      t.string :user
      t.string :kind
      t.string :data
    end
  end
end
