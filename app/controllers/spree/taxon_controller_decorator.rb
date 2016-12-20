Spree::TaxonsController.class_eval do

    def show
      @taxon = Spree::Taxon.friendly.find(params[:id])
      return unless @taxon

      filter_products

      Rails.logger.debug(@filters.inspect)

      @searcher = build_searcher(params.merge(taxon: @taxon.id, include_images: true, search: @filters))
      @products = @searcher.retrieve_products
      @product_properties = Spree::ProductProperty.joins(:product).merge(@products).uniq
      @properties = @product_properties.map { |x| x.property }.uniq

      @taxonomies = Spree::Taxonomy.includes(root: :children)

      respond_to do |format|
        format.html
        format.json {
          render json: { filters: @filters, html: render_to_string(partial: 'shop_body.html.erb') }
        }
      end
    end

    def filter_products
      if params[:filters]
        filters  = params[:filters]
        @filters = {}
        filters.each do |filter_key, filter_values|
          @filters[filter_key] = filter_values.map do |k,v|
            k
          end
        end
      end
    end

end