class CreateNotebooks < ActiveRecord::Migration[5.2]
  def change
    create_table :notebooks do |t|
      t.references :user, foreign_key: true
      t.string :title

      t.timestamps
    end
  end
end
