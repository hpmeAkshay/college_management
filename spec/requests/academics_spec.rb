require 'rails_helper'

RSpec.describe "Academics", type: :request do
  describe "POST academics#create" do
    context 'With valid params' do
      let(:user) { FactoryBot.create(:user) }
      let(:interest) { FactoryBot.create(:interest) }
      let(:qualification) { FactoryBot.create(:qualification) }
    
      let(:valid_params) do
        {
          academic: FactoryBot.attributes_for(
            :academic,
            user_id: user.id,
            interest_id: interest.id,
            qualification_id: qualification.id
          )
        }
      end
      it 'creates a new academic' do
        expect {
          post '/academics', params: valid_params[:academic]
        }.to change(Academic, :count).by(1)
      end
    end
    
    context 'with Invalid parameters' do
      let(:user) { FactoryBot.create(:user) }
      let(:qualification) { FactoryBot.create(:qualification) }
      let(:valid_params) do
        {
          academic: FactoryBot.attributes_for(:academic, interest_id: 1, qualification_id: qualification.id)
        }
      end
  
      it 'it wont creates a new academic' do
        post '/academics', params: valid_params[:academic]
        expect(response.status).to eq(422)      
      end
    end
  end
end
