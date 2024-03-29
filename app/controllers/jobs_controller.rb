class JobsController < ApplicationController
  before_action :set_job, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: %i[new edit create update destroy]
  before_action :limit_to_five_job_postings, only:%i[create new]

  # GET /jobs or /jobs.json
  def index
    @jobs = Job.paginate(page: params[:page], per_page: 25)
    @jobs = @jobs.where("title LIKE ? OR description LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%") if params[:query].present?
    response = HTTParty.get("https://api.itjobs.pt/job/list.json?api_key=#{ENV['IT_JOBS_API_KEY']}&limit=20", format: :plain)
    @it_jobs = JSON.parse response, symbolize_names: true
  end

  # GET /jobs/1 or /jobs/1.json
  def show
  end

  # GET /jobs/new
  def new
    if current_user.role == 'job poster'
      @job = Job.new
    else
      redirect_to '/', status: :unauthorized, notice: 'You are not authorized to post jobs.'
    end
  end

  # GET /jobs/1/edit
  def edit
    if current_user.role == 'job poster'
      if Job.where('user_id = ?', current_user.id).count > 5 || @job.user_id != current_user.id
        @jobs = Job.all
        return redirect_to '/', status: :unauthorized, notice: 'You are not authorize to post more than 5 job postings.'
      end
    else
      redirect_to '/', status: :unauthorized, notice: 'You are not authorized to edit jobs.'
    end
  end

  # POST /jobs or /jobs.json
  def create
    if current_user.role == 'job poster'
      @job = Job.new(job_params)
      @job.user_id = current_user.id
      respond_to do |format|
        if @job.save
          format.html { redirect_to job_url(@job), notice: "Job was successfully created." }
          format.json { render :show, status: :created, location: @job }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @job.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to '/', status: :unauthorized, notice: 'You are not authorized to post jobs.'
    end
  end

  # PATCH/PUT /jobs/1 or /jobs/1.json
  def update
    if current_user.role == 'job poster'
      if Job.where('user_id = ?', current_user.id).count > 5 || @job.user_id != current_user.id
        @jobs = Job.all
        return redirect_to '/', status: :unauthorized, notice: 'You are not authorize to post more than 5 job postings.'
      end

      respond_to do |format|
        if @job.update(job_params) && @job.user_id == current_user.id
          format.html { redirect_to job_url(@job), notice: "Job was successfully updated." }
          format.json { render :show, status: :ok, location: @job }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @job.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to '/', status: :unauthorized, notice: 'You are not authorized to update jobs.'
    end
  end

  # DELETE /jobs/1 or /jobs/1.json
  def destroy
    if current_user.role == 'job poster'
      if @job.user_id != current_user.id
        @jobs = Job.all
        return redirect_to '/', status: :unauthorized, notice: 'You are not authorize to delete this post.'
      end

      @job.destroy

      respond_to do |format|
        format.html { redirect_to jobs_url, notice: "Job was successfully destroyed." }
        format.json { head :no_content }
      end
    else
      redirect_to '/', status: :unauthorized, notice: 'You are not authorized to destroy jobs.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def job_params
      params.require(:job).permit(:title, :description, :company, :location, :application_date)
    end

    # Only allows access to people who don't have more than 5 job postings
    def limit_to_five_job_postings
      if Job.where('user_id = ?', current_user.id).count > 5
        @jobs = Job.all
        return redirect_to '/', status: :unauthorized, notice: 'You are not authorize to post more than 5 job postings.'
      end
    end
end
