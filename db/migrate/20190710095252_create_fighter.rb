class CreateFighter < ActiveRecord::Migration[5.2]
  def change
    create_table :fighters do |t|
      t.string      :name,   null: false

      t.integer     :attack_base_points
      t.integer     :defense_base_points
      t.integer     :health_base_points

      t.timestamps null: false
    end
  end
end
