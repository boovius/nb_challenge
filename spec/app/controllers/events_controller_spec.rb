require 'rails_helper'

RSpec.describe EventsController, :type => :controller do
  describe '#create' do
    let(:success_message)      {{ 'status' => 'ok' }.to_json}
    let(:invalid_kind_message) {{ 'status' => 'invalidKind'}.to_json}

    context 'given good enter data' do
      let(:post_body) do
        {'date'=> '2014-02-28T13:00Z', 'user'=> 'Alice', 'kind'=> 'enter'}
      end

      before { expect(Event.all.count).to eq 0 }

      it 'creates a new event, returns a 200 status and body with message ok' do
        post :create, post_body, :format => :json
        expect(Event.all.count).to eq 1
        expect(Event.first.user).to eq 'Alice'
        expect(response.status).to eq 200
        expect(response.body).to eq success_message
      end
    end

    context 'given an invalid kind' do
      let(:post_body) do
        {'date'=> '2014-02-28T13:00Z', 'user'=> 'Alice', 'kind'=> 'foobar'}
      end

      it 'returns a 400 status and body with message invalid kind' do
        post :create, post_body, :format => :json
        expect(response.status).to eq 400
        expect(response.body).to eq invalid_kind_message
      end
    end
  end

  describe '#index' do
    context 'given a date range as params' do
      let(:leave) { create :leave, :date => Time.parse('2014-02-20T13:00Z') }
      let(:leave_response) do
        {
          'date'=> '2014-02-20T13:00Z',
          'user'=> 'richard nixon',
          'kind'=> 'leave'
        }.to_json
      end

      let(:events) do
        list = []
        list << create(:entry, :date => Time.parse('2014-02-15T13:00Z'))
        list << create(:comment, :date => Time.parse('2014-02-25T13:00Z'), :data => 'foobar')
        list << leave
      end

      before { expect(events.count).to eq 3 }

      it 'returns all the events in the given range' do
        get :index, 'from'=> '2014-02-18T13:00Z', 'to'=> '2014-02-22T13:00Z'
        expect(response.status).to eq 200
        expect(response.body).to eq [leave_response]
      end
    end
  end
end
