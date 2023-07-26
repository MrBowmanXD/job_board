class AddNilAsDefaultValueOfJobIdInApplication < ActiveRecord::Migration[7.0]
  def change
    change_column_default :applications, :job_id, nil
  end
end
