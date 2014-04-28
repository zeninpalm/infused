require 'spec_helper'

describe Infused::Registry do
  before do
    @registry = Infused::Registry.new
  end
  
  context "when adding entry" do
    before do
      class TestEntry; end;
    end
    it "increments entries count by 1" do
      old_count = @registry.entries_count
      @registry.add(TestEntry, id = :test_entry)
      new_count = @registry.entries_count
      expect(new_count).to eq(old_count + 1)
    end
    it "returns same entries given same names" do
      @registry.add(TestEntry, id = :test_entry)
      entry = @registry.get(:test_entry)
      expect(entry).to eq(TestEntry)
    end
  end

  context "when finding entry" do
    context "when the entry is presented" do
      it "returns the entry registered with given id" do
        @registry.add(TestEntry, id = :test_entry)
        expect(@registry.get(:test_entry)).to eq(TestEntry)
      end
    end
    context "when the entry is not presented" do
      it "raises exception to indicate not found error" do
        if @registry.has?(:test_entry)
          @registry.remove(:test_entry)
        end
        expect { @registry.get(:test_entry) }.to raise_error
      end
    end
  end
end