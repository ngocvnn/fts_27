class Admin::ExamsController < ApplicationController
  before_action :check_admin

  def index
    @q = Exam.ransack params[:q]
    @exams = @q.result(distinct: true).paginate page: params[:page],
      per_page: Settings.exams_per_page
    @q.build_condition
  end

  def destroy
    Exam.find(params[:id]).destroy
    flash[:success] = I18n.t "exam.deleted"
    redirect_to admin_exams_url
  end
end
