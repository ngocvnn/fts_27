require 'rails_helper'

RSpec.describe Exam, type: :model do
  subject{FactoryGirl.create :exam}
  it {is_expected.to be_valid}
end
