Spree::TaxonsController.class_eval do

    def show
      @taxon = Spree::Taxon.friendly.find(params[:id])
      return unless @taxon

      @searcher = build_searcher(params.merge(taxon: @taxon.id, include_images: true))
      @products = @searcher.retrieve_products
      @product_properties = Spree::ProductProperty.joins(:product).merge(@products).uniq
      @properties = @product_properties.map { |x| x.property }.uniq

      @taxonomies = Spree::Taxonomy.includes(root: :children)
    end

end