require 'rails_helper'

RSpec.describe EventParams do
  describe '.initialize' do
    subject { described_class.new params }

    context 'given good params with no extra data' do
      context 'when keys are strings' do
        let(:params) do
          {'date'=> '2014-02-28T13:00Z', 'user'=> 'Alice', 'kind'=> 'enter'}
        end

        it 'sets each attribute and holds no errors' do
          expect(subject.date).to eq Time.parse('2014-02-28T13:00Z')
          expect(subject.user).to eq 'Alice'
          expect(subject.kind).to eq :enter
          expect(subject.errors?).to be false
        end
      end

      context 'when keys are symbols' do
        let(:params) do
          {:date => '2014-02-28T13:00Z', :user => 'Alice', :kind => 'enter'}
        end

        it 'sets each attribute and holds no errors' do
          expect(subject.date).to eq Time.parse('2014-02-28T13:00Z')
          expect(subject.user).to eq 'Alice'
          expect(subject.kind).to eq :enter
          expect(subject.errors?).to be false
        end
      end
    end

    context 'when setting params for an empty user' do
      let(:params) do
        {
          'date'=> '2014-02-28T13:00Z',
          'user'=> '',
          'kind'=> 'leave',
        }
      end

      it 'returns an error message for no user' do
        expect(subject.errors?).to eq true
        expect(subject.errors[0]).to eq 'noUser'
      end
    end

    context 'when setting params for a comment' do
      let(:params) do
        {
          'date'=> '2014-02-28T13:00Z',
          'user'=> 'Alice',
          'kind'=> 'comment',
          'message' => message,
        }
      end

      context 'given good params for a message' do
        let(:message) { 'hellooooo world' }
        it 'sets the data attribute to the message' do
          expect(subject.kind).to eq :comment
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
          'kind'=> 'highfive',
          'otheruser' => otheruser,
        }
      end

      context 'given another user' do
        let(:otheruser) { 'Bob' }
        it 'sets the data attribute to the otheruser' do
          expect(subject.kind).to eq :highfive
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

  describe '#error_messages' do
    subject { described_class.new(params).error_messages }

    context 'given one error' do
      let(:params) do
        {
          'date'=> '2014-02-28T13:00Z',
          'user'=> '',
          'kind'=> 'leave',
        }
      end

      it 'returns an error message for no user' do
        expect(subject).to eq 'noUser'
      end
    end

    context 'given more than one error' do
      let(:params) do
        {
          'date'=> '2014-02-28T13:00Z',
          'user'=> '',
          'kind'=> 'foobar',
        }
      end

      it 'returns a joined string of all the error messages' do
        expect(subject).to eq 'noUser,invalidKind'
      end
    end
  end
end
