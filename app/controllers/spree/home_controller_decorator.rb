Spree::HomeController.class_eval do
  layout 'home'

  def index
    @searcher = build_searcher(params.merge(include_images: true))
    @products = @searcher.retrieve_products
    @products = @products.includes(:possible_promotions) if @products.respond_to?(:includes)
    @taxonomies = Spree::Taxonomy.includes(root: :children)

    # slider = Spree::Taxon.where(:name => 'Slider').first
    # @slider_products = slider.products.active if slider

    featured = Spree::Taxon.where(:name => 'Featured').first
    @featured_products = featured.products.active if featured

    latest = Spree::Taxon.where(:name => 'Latest').first
    @latest_products = latest ? latest.products.active : []
  end

end