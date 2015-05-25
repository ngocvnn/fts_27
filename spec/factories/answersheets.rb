FactoryGirl.define do
  factory :answersheet do
    exam_id {rand(100)}
    question_id {rand(100)}
    answer_id {rand(100)}
  end
end
