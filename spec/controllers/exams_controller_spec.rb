require 'rails_helper'

RSpec.describe ExamsController, type: :controller do 
  let(:exam){create :exam}
  
  let(:exams){4.times.map{create :exam}}

  let(:user){create :user}

  before(:each) do
    sign_in user
  end

  describe "GET 'index'" do
    before {get :index}

    it "assigns exam be a new" do
      expect(assigns(:exam)).to be_a_new(Exam)
    end

    it "assigns all users to @users" do
      expect(assigns(:exams)).to match_array exams
    end

    it "renders the index template" do  
      expect(response).to render_template("index")
    end
  end


  describe "POST 'create'" do
    let(:exam){double("Exam")}
    let(:f_exam){create :exam}

    before do
      post :create, exam: {user_id: user.id, category_id: f_exam.category_id}
    end

    it do
      expect(Exam).to receive(:new).with(user_id: user.id, 
        category_id: f_exam.category_id).and_return exam
      Exam.new(user_id: user.id, category_id: f_exam.category_id)
    end

    it do
      expect(exam).to receive(:save)
      exam.save
    end

    context "when the exam saves successfully" do
      before{allow(exam).to receive(:save).and_return(true)}
      it {expect(flash[:success]).to be_present}
      it {expect(response).to redirect_to(exams_path)}
    end

    context "when the exam fails to save" do
      before{allow(exam).to receive(:save).and_return(false)}
      it {expect(response).to redirect_to(action: :index)}
    end
  end


  describe "GET 'edit'" do
    before{get :edit, id: exam.id}

    it "update status and started_time for exam" do
      exam.update_attributes(status: "View", started_time: Time.zone.now) if exam.started_time.nil?
    end

    it "assigns for timeleft" do
      expect(assigns(:timeleft))
        .to eq(20*60 - (Time.zone.now - exam.started_time).to_i) if exam.started_time
    end

    it "renders the edit template" do
      expect(response).to render_template("edit")
    end
  end


  describe "PUT 'update'" do
    before do
      put :update, id: exam, exam: attributes_for(:answersheet)
    end

    context "when the exam updates successfully" do
      it "renders show or edit by timeleft" do
        if exam.time_out?
          expect(response).to redirect_to exam_path(exam)
        else
          expect(response).to redirect_to edit_exam_path(exam)
        end
      end

      it {expect(flash[:success]).to be_present}
    end

    context "when the exam fails to update" do
      it {expect(response).to redirect_to(action: :edit)}
    end
  end
end
