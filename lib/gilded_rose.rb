class GildedRose

  SPECIAL_ITEMS = ["Aged Brie", "Backstage passes to a TAFKAL80ETC concert", "Sulfuras, Hand of Ragnaros"]

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      if item.name == "Sulfuras, Hand of Ragnaros"
        sulfuras_update(item)
      elsif item.name == "Aged Brie"
        brie_update(item)
      elsif item.name == "Backstage passes to a TAFKAL80ETC concert"
        pass_update(item)
      else
        generic_item_update(item)
      end
    end
  end

  def generic_item_update(item)
    item.quality -= 1
    item.quality -= 1 if item.sell_in < 1

    item.quality = 0 if item.quality < 0
    item.sell_in -= 1
  end

  def sulfuras_update(item)
  end

  def brie_update(item)
    item.quality += 1
    item.quality += 1 if item.sell_in < 1

    item.quality = 50 if item.quality > 50
    item.sell_in -= 1
  end

  def pass_update(item)
    item.quality += 1
    item.quality += 1 if item.sell_in <= 10
    item.quality += 1 if item.sell_in <= 5
    item.quality = 0 if item.sell_in < 1

    item.quality = 50 if item.quality > 50
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
