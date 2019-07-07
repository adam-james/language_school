class AddExternalIdToTeachers < ActiveRecord::Migration[5.2]
  def change
    add_column :teachers, :teachers_service_id, :int, null: false
  end
end
