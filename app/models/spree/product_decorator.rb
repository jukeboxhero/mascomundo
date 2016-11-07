Spree::Product.class_eval do
  def in_stock?
    total_on_hand > 0
  end
end