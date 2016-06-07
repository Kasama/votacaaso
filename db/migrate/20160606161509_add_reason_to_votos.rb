class AddReasonToVotos < ActiveRecord::Migration
  def change
    add_column :votos, :reason, :string
  end
end
