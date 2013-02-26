require 'spec_helper'

describe User do
  before do
    @user = User.new
  end

  subject { @user }

  it { should respond_to(:name) }

  describe '#twitter_client' do
    it 'should' do
    end
  end

  describe '.build_from_hash' do
    it 'should' do
    end
  end
end
