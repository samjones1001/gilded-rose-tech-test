class GildedRose

  SPECIAL_ITEMS = ["Aged Brie", "Backstage passes to a TAFKAL80ETC concert", "Sulfuras, Hand of Ragnaros"]

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      if item.name == "Aged Brie"
        BrieUpdater.new(item).update
        return
      elsif item.name == "Sulfuras, Hand of Ragnaros"
        SulfurasUpdater.new(item).update
        return
      elsif item.name == "Backstage passes to a TAFKAL80ETC concert"
        BackstagePassUpdater.new(item).update
        return
      else
        GenericItemUpdater.new(item).update
      end
    end
  end
end

class ItemUpdater
  attr_reader :item

  def initialize(item)
    @item = item
  end

  def update
    @item.update
  end

end

class BrieUpdater < ItemUpdater
  def update
    item.quality += 1
    item.quality += 1 if item.sell_in < 1

    item.quality = 50 if item.quality > 50
    item.sell_in -= 1
  end
end

class SulfurasUpdater < ItemUpdater
  def update
  end
end

class BackstagePassUpdater < ItemUpdater
  def update
    item.quality += 1
    item.quality += 1 if item.sell_in <= 10
    item.quality += 1 if item.sell_in <= 5
    item.quality = 0 if item.sell_in < 1

    item.quality = 50 if item.quality > 50
    item.sell_in -= 1
  end
end

class GenericItemUpdater < ItemUpdater
  def update
    item.quality -= 1
    item.quality -= 1 if item.sell_in < 1

    item.quality = 0 if item.quality < 0
    item.sell_in -= 1
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
