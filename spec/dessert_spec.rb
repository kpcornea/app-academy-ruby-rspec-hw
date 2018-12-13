require 'rspec'
require 'dessert'
require 'byebug'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  let(:chef) { double("chef") }
  subject(:dessert) { Dessert.new("brownie", 3, chef)}

  describe "#initialize" do
    it "sets a type" do
      expect(dessert.type).to eq("brownie")
    end

    it "sets a quantity" do
      expect(dessert.quantity).to eq(3)
    end

    it "starts ingredients as an empty array" do
      expect(dessert.ingredients).to be_empty
    end

    it "raises an argument error when given a non-integer quantity" do
      expect { Dessert.new("brownie", "dog", chef) }.to raise_error(ArgumentError)
    end
  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do
      dessert.add_ingredient("chocolate")
      dessert.add_ingredient("flour")
      dessert.add_ingredient("chili")
      dessert.add_ingredient("fur")
      dessert.add_ingredient("vanilla")
      expect(dessert.ingredients).to eq(%w(chocolate flour chili fur vanilla))
    end
  end

  describe "#mix!" do
    it "shuffles the ingredient array" do
      dessert.add_ingredient("chocolate")
      dessert.add_ingredient("flour")
      dessert.add_ingredient("chili")
      dessert.add_ingredient("fur")
      dessert.add_ingredient("vanilla")
      before_mix = dessert.ingredients.dup
      dessert.mix!
      expect(before_mix).to_not eq(dessert.ingredients)
    end
  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do
      dessert.eat(2)
      expect(dessert.quantity).to eq(1)
    end

    it "raises an error if the amount is greater than the quantity" do
      expect { dessert.eat(4) }.to raise_error(RuntimeError)
    end
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do
      allow(chef).to receive(:titleize).and_return("Chef Dude the Great Baker")

      expect(dessert.serve).to include("Chef Dude the Great Baker")
    end
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do
      expect(chef).to receive(:bake).with(dessert)
      dessert.make_more
    end
  end
end
