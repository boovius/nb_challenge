require 'spec_helper'

RSpec.describe EventsController do
  describe '#create' do



    context 'given good stuff' do
      let(:post_body) do
        {"date"=> "2014­02­28T13:00Z", "user"=> "Alice", "type"=> "enter"}
      end

      it 'returns a 200 status and body with message ok' do
        post :event, post_body, :format => :json
        expect(response.status).to eq 200
      end
    end

    context 'given bad stuff' do

    end
  end
end
