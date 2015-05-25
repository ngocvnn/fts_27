class Exam < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :answersheets, dependent: :destroy

  accepts_nested_attributes_for :answersheets

  before_update :update_result
  # before_create :random_questions

  scope :created_sort, -> {order created_at: :desc}

  def time_out?
    if started_time
      now = Time.zone.now
      expired_time = started_time + Settings.allow_period.minutes
      now > expired_time
    end
  end

  private
  def update_result
    score = answersheets.select do |answersheet|
      answersheet.answer && answersheet.answer.correct
    end.count
    self.result = "#{score.to_s}/#{Settings.default_questions_num}"
  end

  # def random_questions
  #   questions = self.category.questions.random_questions
  #   questions.each{|question| self.answersheets.build question: question}
  # end
end
