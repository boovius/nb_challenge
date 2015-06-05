require 'rails_helper'

RSpec.describe EventParams do
  describe '.initialize' do
    subject { described_class.new params }

    context 'given good params with no extra data' do
      context 'when keys are strings' do
        let(:params) do
          {'date'=> '2014-02-28T13:00Z', 'user'=> 'Alice', 'type'=> 'enter'}
        end

        it 'sets each attribute and holds no errors' do
          expect(subject.date).to eq Time.parse('2014-02-28T13:00Z')
          expect(subject.user).to eq 'Alice'
          expect(subject.type).to eq :enter
          expect(subject.errors?).to be false
        end
      end

      context 'when keys are symbols' do
        let(:params) do
          {:date => '2014-02-28T13:00Z', :user => 'Alice', :type => 'enter'}
        end

        it 'sets each attribute and holds no errors' do
          expect(subject.date).to eq Time.parse('2014-02-28T13:00Z')
          expect(subject.user).to eq 'Alice'
          expect(subject.type).to eq :enter
          expect(subject.errors?).to be false
        end
      end
    end

    context 'when setting params for a comment' do
      let(:params) do
        {
          'date'=> '2014-02-28T13:00Z',
          'user'=> 'Alice',
          'type'=> 'comment',
          'message' => message,
        }
      end

      context 'given good params for a message' do
        let(:message) { 'hellooooo world' }
        it 'sets the data attribute to the message' do
          expect(subject.type).to eq :comment
          expect(subject.data).to eq 'hellooooo world'
        end
      end

      context 'given an empty message' do
        let(:message) { '' }
        it 'returns with an error for an empty message' do
          expect(subject.errors?).to eq true
          expect(subject.errors[0]).to eq 'emptyMessageSent'
        end
      end
    end

    context 'when setting params for a highfive' do
      let(:params) do
        {
          'date'=> '2014-02-28T13:00Z',
          'user'=> 'Alice',
          'type'=> 'highfive',
          'otheruser' => otheruser,
        }
      end

      context 'given another user' do
        let(:otheruser) { 'Bob' }
        it 'sets the data attribute to the otheruser' do
          expect(subject.type).to eq :highfive
          expect(subject.data).to eq 'Bob'
        end
      end

      context 'given no other user' do
        let(:otheruser) { '' }
        it 'returns with an error for no highfive receiver' do
          expect(subject.errors?).to eq true
          expect(subject.errors[0]).to eq 'noHighFiveReceiver'
        end
      end
    end
  end
end
