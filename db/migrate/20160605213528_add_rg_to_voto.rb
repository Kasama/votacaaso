class AddRgToVoto < ActiveRecord::Migration
  def change
    add_column :votos, :rg, :string
  end
end
