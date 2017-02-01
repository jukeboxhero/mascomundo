Spree::Product.class_eval do
  acts_as_reviewable :scale => 0..5
  
  def in_stock?
    total_on_hand > 0
  end
end