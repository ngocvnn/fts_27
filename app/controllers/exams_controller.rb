class ExamsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @exam = Exam.new
    @exams = current_user.exams.created_sort
      .paginate page: params[:page], per_page: 5
  end 

  def show
  end

  def create
    @exam.user_id = current_user.id

    if @exam.save
      flash[:success] = t("flash.exam_created")
      redirect_to exams_path
    else
      render :index
    end
  end

  def edit
    if @exam.started_time.nil?
      started_time = Time.zone.now
      @exam.update_attributes status: "View", started_time: started_time
    end
    @timeleft = Settings.allow_period*60 - (Time.zone.now - @exam.started_time).to_i
  end

  def update
    if @exam.update_attributes update_params
      flash[:success] = t("flash.ans_sheet_update")
      @exam.time_out? ? (redirect_to exam_path @exam) 
        : (redirect_to edit_exam_path @exam)
    else
      render :edit
    end
  end

  private
  def create_params
    params.require(:exam).permit :category_id
  end

  def update_params
    params.require(:exam).permit answersheets_attributes: [:id, :answer_id]
  end
end
