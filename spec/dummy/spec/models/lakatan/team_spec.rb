require 'rails_helper'

module Lakatan
  RSpec.describe Team, type: :model do
    it 'has a valid factory' do
      expect(build(:team)).to be_valid
    end
  end
end
