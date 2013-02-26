require 'spec_helper'

describe Authorization do
  before do
    @authorization = Authorization.new
  end

  subject { @authorization }

  it { should respond_to(:provider) }
  it { should respond_to(:uid) }

  describe '#authorize' do
    it 'should' do
    end
  end

  describe '#find_by_hash' do
    it 'should' do
    end
  end
end
