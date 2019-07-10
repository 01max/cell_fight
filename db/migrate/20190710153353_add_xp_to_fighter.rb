class AddXpToFighter < ActiveRecord::Migration[5.2]
  def change
    change_table :fighters do |t|
      t.integer :xp, default: 1
    end
  end
end
