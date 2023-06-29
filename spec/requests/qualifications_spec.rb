require 'rails_helper'

RSpec.describe " qualificationss", type: :request do
  describe "POST / qualifications :" do

    context 'Create  qualifications' do
      let(:valid_params) do
        {
           qualifications: FactoryBot.attributes_for(:qualification)
        }
      end
     it " it will create  qualifications" do
        post '/qualifications', params: valid_params
          expect(response.status).to eq(200)
      end
    end

     it "With Invalid params" do
        post '/qualifications', params: { qualifications: {name: ''}}, as: :json
        expect(response.status).to_not eq(200)
      end
  end

  describe 'GET  qualifications#index'
    context 'with invalid parameters' do
      let(:valid_params) do
        {
           qualifications: FactoryBot.attributes_for(:qualification)
        }
      end

      before do
        Qualification.destroy_all
        post '/qualifications', params: valid_params
        post '/qualifications', params: valid_params
      end
      
      it 'returns a successful response' do
        get '/qualifications'
        expect(response).to have_http_status(200)
      end

      it 'returns all events' do
        get '/qualifications'
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['data'].length).to eq(2)
    end
  end
end

