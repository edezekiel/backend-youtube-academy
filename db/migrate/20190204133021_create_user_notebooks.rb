class CreateUserNotebooks < ActiveRecord::Migration[5.2]
  def change
    create_table :user_notebooks do |t|
      t.references :user, foreign_key: true
      t.references :notebook, foreign_key: true

      t.timestamps
    end
  end
end
