class ApplicationsController < ApplicationController

  before_action :authenticate_user!, only: %i[create]

  def create
    if current_user.role == 'job seeker'
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
    else
      redirect_to '/', status: :unauthorized, notice: 'You are not authorized to create job applications.'
    end
  end

  def edit
    if current_user.role == 'job seeker'
      # resume as usual
    else
      redirect_to '/', status: :unauthorized, notice: 'You are not authorized to edit a job application.'
    end
  end

  def update
    if current_user.role == 'job seeker'
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
    else
      redirect_to '/', status: :unauthorized, notice: 'You are not authorized to update a job application.'
    end
  end

  def destroy
    if current_user.role == 'job seeker'
      @application = Application.find(params[:application][:application_id])
      if @application.destroy
        flash[:alert] = "You deleted the job application successfully."
      else
        flash[:notice] = "You did not delete the job application."
      end
    else
      redirect_to '/', status: :unauthorized, notice: 'You are not authorized to update a job application.'
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
