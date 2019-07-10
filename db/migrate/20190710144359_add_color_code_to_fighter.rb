class AddColorCodeToFighter < ActiveRecord::Migration[5.2]
  def change
    change_table :fighters do |t|
      t.string :color_code
    end
  end
end
