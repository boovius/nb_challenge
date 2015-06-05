require 'rails_helper'

RSpec.describe EventsController, :type => :controller do
  describe '#create' do


    let(:success_message)      {{ "status" => "ok" }.to_json}
    let(:invalid_kind_message) {{ "status" => "invalidKind"}.to_json}

    context 'given good enter data' do
      let(:post_body) do
        {"date"=> "2014-02-28T13:00Z", "user"=> "Alice", "kind"=> "enter"}
      end

      it 'returns a 200 status and body with message ok' do
        post :create, post_body, :format => :json
        expect(response.status).to eq 200
        expect(response.body).to eq success_message
      end
    end

    context 'given an invalid kind' do
      let(:post_body) do
        {"date"=> "2014-02-28T13:00Z", "user"=> "Alice", "kind"=> "foobar"}
      end

      it 'returns a 400 status and body with message invalid kind' do
        post :create, post_body, :format => :json
        expect(response.status).to eq 400
        expect(response.body).to eq invalid_kind_message
      end
    end
  end
end
