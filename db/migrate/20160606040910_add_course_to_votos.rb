class AddCourseToVotos < ActiveRecord::Migration
  def change
    add_column :votos, :course, :string
  end
end
