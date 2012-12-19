require 'spec_helper'

describe "Users" do
  subject { page }

  describe "show" do
    let(:user) { create :user }

    describe "without feats" do
      describe "logged in as current user" do
        before do
          login(user)
        end

        it { should have_content("You haven't completed any feats!") }
      end

      describe "logged in as other user" do
        before do
          @other_user = create :user
          login(user)
          visit user_path(@other_user)
        end

        it { should have_content("This user has no feats") }
      end

      describe "not logged in" do
        before do
          visit user_path(user)
        end

        it { should have_content("This user has no feats") }
      end
    end

    describe "with feats" do
      describe "current user" do

      end

      describe "other user" do

      end

      describe "no user" do

      end
    end
  end
end
