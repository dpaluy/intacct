require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe 'Intacct' do
  it 'has a version' do
    expect(Intacct::VERSION).not_to be_nil
  end
end
