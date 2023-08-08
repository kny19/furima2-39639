require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      item = build(:item)
      expect(item).to be_valid
    end

    it "is not valid without an item_name" do
      item = build(:item, item_name: nil)
      expect(item).not_to be_valid
    end

    it "is not valid without a price" do
      item = build(:item, price: nil)
      expect(item).not_to be_valid
    end

    it "is not valid with a non-integer price" do
      item = build(:item, price: "abc")
      expect(item).not_to be_valid
    end

    it "is not valid with a price less than or equal to 0" do
      item = build(:item, price: 0)
      expect(item).not_to be_valid
    end

    it "is not valid without a description" do
      item = build(:item, description: nil)
      expect(item).not_to be_valid
    end

    it "is not valid without a category" do
      item = build(:item, category: nil)
      expect(item).not_to be_valid
    end

    it "is not valid without a condition" do
      item = build(:item, condition: nil)
      expect(item).not_to be_valid
    end

    it "is not valid without a shipping_burden" do
      item = build(:item, shipping_burden: nil)
      expect(item).not_to be_valid
    end

    it "is not valid without a shipping_area" do
      item = build(:item, shipping_area: nil)
      expect(item).not_to be_valid
    end

    it "is not valid without a shipping_day" do
      item = build(:item, shipping_day: nil)
      expect(item).not_to be_valid
    end

    it "is not valid without an item_image" do
      item = build(:item, item_image: nil)
      expect(item).not_to be_valid
    end
  end

  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:category) }
    it { should belong_to(:shipping_burden) }
    it { should belong_to(:shipping_area) }
    it { should belong_to(:shipping_day) }
    it { should have_one_attached(:item_image) }
  end
end