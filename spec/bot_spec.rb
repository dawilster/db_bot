require 'spec_helper'

describe DbBot do
  describe 'self.message' do
    subject{ DbBot.message(message) }
    let(:message) { 'hello world'}

    before do
      mock_model('User')
    end

    it { expect(subject.response).to eq 'Please try again' }

    context "class doesn't exist" do
      let(:message) { 'how many dogs have been created?' }

      it 'returns error' do
        expect(subject.response).to eq 'Class cannot be found'
      end
    end

    context 'return' do
      let(:message) { 'return the 3 most recent users' }

      context 'no users' do
        before do
          expect(User).to receive(:limit).and_return([])
        end

        it { expect(subject.response).to eq "There weren't any users" }
      end

      context 'users exist' do
        before do
          expect(User).to receive(:limit).and_return([1, 2, 3])
        end

        it 'returns collection' do
          expect(subject.number).to eq 3
          expect(subject.verb).to eq 'return'
          expect(subject.table).to eq 'users'
          expect(subject.response).to eq 'There you go'
          expect(subject.collection.size).to eq 3
        end
      end
    end

    context 'count' do
      context 'all' do
        let(:message) { 'how many users have been created?' }

        it 'returns no. of users' do
          expect(User).to receive(:all).and_return([1])

          expect(subject.table).to eq 'users'
          expect(subject.query).to eq 'created'
          expect(subject.response).to eq '1'
        end
      end

      context 'where' do
        let(:message) { 'how many users were created this week?' }

        it 'returns no. of users' do
          expect(User).to receive(:where).and_return([1, 2])

          expect(subject.table).to eq 'users'
          expect(subject.query).to eq 'created'
          expect(subject.when.is_a?(DateTime)).to be_truthy
          expect(subject.response).to eq '2'
        end

      end

    end

  end
end
