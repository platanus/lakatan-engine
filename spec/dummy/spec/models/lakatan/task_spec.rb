require 'rails_helper'

module Lakatan
  RSpec.describe Task, type: :model do
    it 'has a valid factory' do
      expect(build(:task)).to be_valid
    end
  end
end
