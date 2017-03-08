class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      ItemUpdater.new(item).update
    end
  end
end


class ItemUpdater
  attr_reader :item

  SPECIAL_ITEMS = {
    "Aged Brie" =>                                    Proc.new { |item|
                                                      item.quality += 1
                                                      item.quality += 1 if item.sell_in < 1
                                                      item.quality = 50 if item.quality > 50
                                                      item.sell_in -= 1
                                                      },
    "Sulfuras, Hand of Ragnaros" =>                   Proc.new { |item|
                                                      },
    "Backstage passes to a TAFKAL80ETC concert" =>    Proc.new { |item|
                                                        item.quality += 1
                                                        item.quality += 1 if item.sell_in <= 10
                                                        item.quality += 1 if item.sell_in <= 5
                                                        item.quality = 0 if item.sell_in < 1
                                                        item.quality = 50 if item.quality > 50
                                                        item.sell_in -= 1
                                                      },
    "Generic item" =>                                 Proc.new { |item|
                                                      item.quality -= 1
                                                      item.quality -= 1 if item.sell_in < 1
                                                      item.quality = 0 if item.quality < 0
                                                      item.sell_in -= 1
                                                      }
  }

  def initialize(item)
    @item = item
  end

  def update
    if SPECIAL_ITEMS.include?(item.name)
      SPECIAL_ITEMS[item.name].call(item)
    else
      SPECIAL_ITEMS["Generic item"].call(item)
    end
  end

  private

  def update_picker
    if item.name == "Aged Brie"
      SPECIAL_ITEMS[item.name].call(item)
      return
    end
    if SPECIAL_ITEMS.include?(item.name)
      @updater = eval(SPECIAL_ITEMS[item.name])
    else
      @updater = GenericItemUpdater
    end
  end

  def increase_quality
    @item.quality += 1
  end

  def decrease_quality
    @item.quality -= 1
  end

  def update_sell_in
    @item.sell_in -= 1
  end

end


class BrieUpdater < ItemUpdater
  def update
    increase_quality
    increase_quality if item.sell_in < 1

    item.quality = 50 if item.quality > 50
    update_sell_in
  end
end


class SulfurasUpdater < ItemUpdater
  def update
  end
end


class BackstagePassUpdater < ItemUpdater
  def update
    increase_quality
    increase_quality if item.sell_in <= 10
    increase_quality if item.sell_in <= 5
    item.quality = 0 if item.sell_in < 1

    item.quality = 50 if item.quality > 50
    update_sell_in
  end
end


class GenericItemUpdater < ItemUpdater
  def update
    decrease_quality
    decrease_quality if item.sell_in < 1

    item.quality = 0 if item.quality < 0
    update_sell_in
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
