json.extract! job, :id, :title, :description, :company, :location, :application_date, :created_at, :updated_at
json.url job_url(job, format: :json)
