require_relative '../lib/gilded_rose'

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq "foo"
    end

    it "lowers the sell_in by one after a day" do
      items = [Item.new("item", 1, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].sell_in).to eq 0
    end

    it "lowers the sell_in by n after n days" do
      n = 5
      items = [Item.new("item", n, 0)]

      n.times do
        GildedRose.new(items).update_quality
      end

      expect(items[0].sell_in).to eq(0)
    end

    it "never lowers quality below 0" do
      items = [Item.new("item", 0, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq(0)
    end

    context 'generic item' do
      context 'before sell_in' do
        it 'lowers quality by one after one day' do
          items = [Item.new("item", 1, 1)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(0)
        end

        it 'lowers quality by n after n days' do
          n = 5
          items = [Item.new("item", n, n)]

          n.times do
            GildedRose.new(items).update_quality
          end

          expect(items[0].quality).to eq(0)
        end
      end

      context 'after sell_in' do
        it 'lowers quality by two after a day' do
          items = [Item.new("item", 0, 2)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(0)
        end

        it 'lowers quality by 2n after n days' do
          n = 5
          items = [Item.new("item", 0, 10)]

          n.times do
            GildedRose.new(items).update_quality
          end

          expect(items[0].quality).to eq(0)
        end
      end
    end

    
  end
end
