class CreateOutlineNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :outline_notes do |t|
      t.references :notebook, foreign_key: true
      t.references :outline, foreign_key: true

      t.timestamps
    end
  end
end
