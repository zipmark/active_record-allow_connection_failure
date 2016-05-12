require 'spec_helper'

describe ActiveRecord::AllowConnectionFailure do
  it 'has a version number' do
    expect(ActiveRecord::AllowConnectionFailure::VERSION).not_to be nil
  end

  it 'does something useful' do
    expect(false).to eq(true)
  end
end
