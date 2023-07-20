class CreateApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :applications do |t|
      t.text :applicant_information
      t.text :resume_text
      t.text :cover_letter
      t.string :application_status
      t.date :submitted_at
      t.references :user, null: false, foreign_key: true
      t.references :job, null: false, foreign_key: true

      t.timestamps
    end
  end
end
