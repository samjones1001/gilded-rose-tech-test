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

  UPDATE_RULES = {
    "Aged Brie" =>                                    Proc.new do |item|
                                                        item.quality += 1
                                                        item.quality += 1 if item.sell_in < 1
                                                        item.quality = 50 if item.quality > 50
                                                        item.sell_in -= 1
                                                      end,
    "Sulfuras, Hand of Ragnaros" =>                   Proc.new {},
    "Backstage passes to a TAFKAL80ETC concert" =>    Proc.new do |item|
                                                        item.quality += 1
                                                        item.quality += 1 if item.sell_in <= 10
                                                        item.quality += 1 if item.sell_in <= 5
                                                        item.quality = 0 if item.sell_in < 1
                                                        item.quality = 50 if item.quality > 50
                                                        item.sell_in -= 1
                                                      end,
    "Generic item" =>                                 Proc.new do |item|
                                                        item.quality -= 1
                                                        item.quality -= 1 if item.sell_in < 1
                                                        item.quality = 0 if item.quality < 0
                                                        item.sell_in -= 1
                                                      end
  }

  def initialize(item)
    @item = item
  end

  def update
    UPDATE_RULES.include?(item.name) ? UPDATE_RULES[item.name].call(item) : UPDATE_RULES["Generic item"].call(item)
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
