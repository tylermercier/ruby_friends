require File.dirname(__FILE__) + "/spec_helper"

describe Post do
  before do
    @post = Post.new
  end

  subject { @post }

  it { should respond_to(:title) }
  it { should respond_to(:body) }

  describe 'validations' do
    before :each do
      @post.title = 'title'
      @post.body = 'body'
    end

    it 'should check presence of title' do
      @post.title = nil
      should_not be_valid
    end

    it 'should check length of title' do
      @post.title = '12'
      should_not be_valid
    end

    it 'should check presence of body' do
      @post.body = nil
      should_not be_valid
    end

  end
end
