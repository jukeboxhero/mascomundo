Spree::Product.class_eval do
  def default_image
    images.first
  end
end