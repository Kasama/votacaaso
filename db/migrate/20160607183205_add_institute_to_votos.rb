class AddInstituteToVotos < ActiveRecord::Migration
  def change
    add_column :votos, :institute, :string
  end
end
