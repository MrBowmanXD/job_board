class ApplicationsController < ApplicationController

  before_action :authenticate_user!, only: %i[create]

  def create
    @job = Job.find(params[:job_id])
    @application = @job.applications.new(application_params)
    @application.submitted_at = Date.today
    @application.user_id = current_user.id
    @application.job_id = params[:job_id]
    if @application.save
      redirect_to job_path(@job)
    else
      redirect_to :root, status: :unauthorized, notice: 'Something went wrong while creating an application to the job post.'
    end
  end

  def edit
  end

  def update
    @job = Job.find(params[:job_id])
    @application = Application.find(params[:id])
      if @application.update_attribute(:application_status, application_status_param["application_status"])
        if @application.application_status.present?
          if @application.application_status == 'Accepted'
            flash[:notice] = "You just accepted an application, congratulations."
          else
            flash[:alert] = "You just declined an application."
          end
        end
        redirect_to job_path(@job)
      else
        redirect_to job_path(@job), status: :unprocessable_entity, notice: 'Unable to update the application status.'
      end
  end


  private
  def application_params
    params.require(:application).permit(:applicant_information, :resume_text, :cover_letter)
  end

  def application_status_param
    params.require(:application).permit(:application_status)
  end

end
