class ExamsController < ApplicationController
  load_and_authorize_resource

  def index
    @exam = Exam.new

    if params[:q].blank?
      @search = Exam.ransack params[:q]
      @exams = @search.result.created_sort.paginate page: params[:page], per_page: 5
    else
      @search = Exam.ransack category_id_eq: params[:q][:category_id]
      @exams = @search.result(distinct: true).created_sort.paginate page: params[:page], per_page: 5
    end 
  end 

  def show
  end

  def create
    @exam.user_id = current_user.id

    if @exam.save
      flash[:success] = t("flash.exam_created")
      redirect_to exams_path
    else
      redirect_to :back
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
      redirect_to :back
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
