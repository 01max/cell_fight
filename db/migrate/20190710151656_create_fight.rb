class CreateFight < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'hstore';

    create_table :fights do |t|
      t.references :fighter_a
      t.references :fighter_b
      t.references :winner

      t.json :hits,       default: {}
      t.integer :xp_gain, default: 0

      t.timestamps null: false
    end
  end
end
