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


  private
  def application_params
    params.require(:application).permit(:applicant_information, :resume_text, :cover_letter)
  end

end
