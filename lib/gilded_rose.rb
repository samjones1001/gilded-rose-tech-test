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
    if item.quality > 0
        item.quality -= 1
        item.quality -= 1 if item.sell_in < 1
    end
    item.sell_in -= 1
  end

  def sulfuras_update(item)
  end

  def brie_update(item)
    if item.quality < 50
      if item.sell_in > 0
        item.quality += 1
      else
        if item.quality < 49
          item.quality += 2
        else
          item.quality += 1
        end
      end
    end
    item.sell_in -= 1
  end

  def pass_update(item)
    if item.quality < 50
      if item.sell_in > 10
        item.quality += 1
      elsif item.sell_in > 5
        if item.quality < 49
          item.quality += 2
        else
          item.quality += 1
        end
      elsif item.sell_in > 0
        if item .quality < 48
          item.quality += 3
        else
          item.quality = 50
        end
      else
        item.quality -= item.quality
      end
    end
    if item.sell_in < 1
      item.quality -= item.quality
    end
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
