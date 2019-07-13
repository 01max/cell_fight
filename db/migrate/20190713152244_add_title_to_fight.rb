class AddTitleToFight < ActiveRecord::Migration[5.2]
  def change
    change_table :fights do |t|
      t.string :title
    end
  end
end
