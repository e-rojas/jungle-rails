require 'rails_helper'

RSpec.describe Product, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
describe 'Validations' do
    # validation tests/examples here
    subject { described_class.new(name: 'Item', price_cents: 1000, quantity: 5, category: Category.new) }

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages.first).to eq "Name can't be blank"
    end

    it 'is not valid without a price' do
      subject.price_cents = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages.second).to eq "Price is not a number"
    end

    it 'is not valid without a quantity' do
      subject.quantity = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages.first).to eq "Quantity can't be blank"
    end

    it 'is not valid without a category' do
      subject.category = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages.first).to eq "Category can't be blank"
    end
  end
end
