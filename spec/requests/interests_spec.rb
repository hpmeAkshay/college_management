require 'rails_helper'

RSpec.describe "Interests", type: :request do
  describe "POST /interest :" do

    context 'Create Interest' do
      let(:valid_params) do
        {
          interest: FactoryBot.attributes_for(:interest)
        }
      end
     it " I will crate interest" do
        post '/interests', params: valid_params
          expect(response.status).to eq(200)
      end
    end


     it "With Invalid params" do
        post '/interests', params: {interest: {name: ''}}, as: :json
          expect(response.status).to_not eq(200)
      end
  end

  describe 'GET interests#index'
    context 'with invalid parameters' do
      let(:valid_params) do
        {
          interest: FactoryBot.attributes_for(:interest)
        }
      end

      before do
        Interest.destroy_all
        post '/interests', params: valid_params
        post '/interests', params: valid_params
        
      end
      
      it 'returns a successful response' do
        get '/interests'
        expect(response).to have_http_status(200)
      end

      it 'returns all events' do
        get '/interests'
        parsed_response = JSON.parse(response.body)
        p "22222222222222222222222222222222"
        p parsed_response
        expect(parsed_response['data'].length).to eq(2)
    end
  end
end


