require 'spec_helper'

describe Bot do
  it 'has a version number' do
    expect(Bot::VERSION).not_to be nil
  end

  it 'does something useful' do
    expect(false).to eq(true)
  end
end
