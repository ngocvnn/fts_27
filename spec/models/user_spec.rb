require 'rails_helper'

RSpec.describe User, type: :model do
  subject {FactoryGirl.create :user}
  it {is_expected.to be_valid}
    
  it {is_expected.to validate_presence_of :name}
  it {is_expected.to validate_presence_of :email}
  it {is_expected.to validate_presence_of :password}

  it {is_expected.to validate_uniqueness_of :email}

  it {is_expected.to validate_length_of(:password).is_at_least(8)}

  it {is_expected.to have_many(:exams).dependent(:destroy)}
  it {is_expected.to define_enum_for(:role).with([:admin, :registered])}

  it {is_expected.to callback(:set_default_role).before(:create)}

  # describe '#avatar_size' do
  # end

  # describe '#set_default_role' do
    
  # end
  
  # describe "#validate" do
  #   subject{FactoryGirl.create :user}

  #   context "when no name" do
  #     before{subject.name = nil}
  #     it {is_expected.to have(1).error_on(:name)}
  #   end

  #   context "when no email" do
  #     before{subject.email = nil}
  #     it {is_expected.to have(1).error_on(:email)}
  #   end

  #   context "when no password" do
  #     before{subject.password = nil}
  #     it {is_expected.to have(1).error_on(:password)}
  #   end

  #   context "when password greater 8 characters" do
  #     before{subject.password = "sdsdsds"}
  #     it {is_expected.to have(1).error_on(:password)}
  #   end
  # end

  # describe "#email" do
  #   subject {FactoryGirl.build :user}
  #   before {@another_user = FactoryGirl.create :user}
  #   it {is_expected.to have(1).error_on(:email)}
  # end

  # it "is valid with a name, email and password"
  # it "is valid with password at least 8 characters"
  # it "is invalid without a name"
  # it "is invalid without a password"
  # it "is invalid without an email"
  # it "is invalid with a duplicate email address"
end
