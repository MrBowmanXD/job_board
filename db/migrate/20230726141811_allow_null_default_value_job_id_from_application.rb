class AllowNullDefaultValueJobIdFromApplication < ActiveRecord::Migration[7.0]
  def change
    change_column :applications, :job_id, :integer, null: true, default: nil
  end
end
