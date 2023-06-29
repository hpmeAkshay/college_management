require 'rails_helper'

RSpec.describe Interest, type: :model do
  describe 'validations' do
    it 'validates presence of name' do
      interest = Interest.new(name: '')
      expect(interest).to_not be_valid
      expect(interest.errors[:name]).to include("can't be blank")
    end

    context 'associations' do
      it 'has one academic' do
        association = described_class.reflect_on_association(:academic)
        expect(association.macro).to eq(:has_one)
      end
    end
end
end
