class CreateOutlines < ActiveRecord::Migration[5.2]
  def change
    create_table :outlines do |t|
      t.references :user, foreign_key: true
      t.string :videoId
      t.string :videoTitle
      t.string :notes

      t.timestamps
    end
  end
end
