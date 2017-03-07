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

    context 'when item is generic' do
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

    context 'when item is Aged Brie' do
      context 'before sell_in' do
        it 'raises quality by one after a day' do
          items = [Item.new("Aged Brie", 1, 0)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(1)
        end

        it 'raises quality by n after n days' do
          n = 5
          items = [Item.new("Aged Brie", n, 0)]

          n.times do
            GildedRose.new(items).update_quality
          end

          expect(items[0].quality).to eq(5)
        end

        it 'never raises quality beyond 50' do
          items = [Item.new("Aged Brie", 1, 50)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(50)
        end
      end

      context 'after sell_in' do
        it 'raises quality by two after a day' do
          items = [Item.new("Aged Brie", 0, 0)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(2)
        end

        it 'raises quality by 2n after n days' do
          n = 5
          items = [Item.new("Aged Brie", 0, 0)]

          n.times do
            GildedRose.new(items).update_quality
          end

          expect(items[0].quality).to eq(10)
        end

        it 'only raises quality to 50 when quality is at 49' do
          items = [Item.new("Aged Brie", 0, 49)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(50)
        end
      end
    end

    context 'when item is Sulfuras, Hand of Ragnaros' do
      it 'does not change sell_in' do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 1, 80)]
        GildedRose.new(items).update_quality
        expect(items[0].sell_in).to eq(1)
      end

      it 'does not change quality' do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 1, 80)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq(80)
      end
    end

    context 'when item is Backstage passes to a TAFKAL80ETC concert' do
      context 'when sell_in is greater than 10' do
        it 'increases quality by one after each day' do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 0)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(1)
        end

        it 'increases quality by n after n days' do
          n = 5
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 0)]

          n.times do
            GildedRose.new(items).update_quality
          end

          expect(items[0].quality).to eq(5)
        end

        it 'never increases quality beyond 50' do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 50)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(50)
        end
      end

      context 'when sell_in is less than or equal to 10 but more than 5' do
        it 'increases quality by two after each day' do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 0)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(2)
        end

        it 'increases quality by 2n after n days' do
          n = 5
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 0)]

          n.times do
            GildedRose.new(items).update_quality
          end

          expect(items[0].quality).to eq(10)
        end

        it 'only raises quality to 50 when quality is at 49' do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 49)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(50)
        end
      end

      context 'when sell_in is less than or equal to 5 but more than 0' do
        it 'increases quality by three after each day' do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 0)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(3)
        end

        it 'increases quality by 3n after n days' do
          n = 5
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 0)]

          n.times do
            GildedRose.new(items).update_quality
          end

          expect(items[0].quality).to eq(15)
        end

        it 'only raises quality to 50 when quality is at 48 or more' do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 48)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(50)
        end
      end

      context 'after sell_in' do
        it 'sets quality to 0' do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 50)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(0)
        end

        it 'does not change quality' do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 0)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(0)
        end
      end
    end



  end
end
