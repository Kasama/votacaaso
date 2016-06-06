class CreateVotos < ActiveRecord::Migration
  def change
    create_table :votos do |t|
      t.string :name
      t.integer :nusp
      t.boolean :vote

      t.timestamps null: false
    end
  end
end
