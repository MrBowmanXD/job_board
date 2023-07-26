class DefaultValueOfJobIdNotNilApplication < ActiveRecord::Migration[7.0]
  def change
    change_column :applications, :job_id, :integer, null: false, default: 1
  end
end
