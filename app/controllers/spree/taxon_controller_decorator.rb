Spree::TaxonsController.class_eval do
    helper_method :sorting_param

    def show
      @taxon = Spree::Taxon.friendly.find(params[:id])
      return unless @taxon

      filter_products

      @searcher = build_searcher(params.merge(taxon: @taxon.id, include_images: true, search: @filters))
      @products = @searcher.retrieve_products
      @product_properties = Spree::ProductProperty.joins(:product).merge(@taxon.products).uniq
      @properties = @product_properties.map { |x| x.property }.uniq

      @taxonomies = Spree::Taxonomy.includes(root: :children)

      @products = @products.select('spree_products.*, spree_prices.amount').reorder('').send(sorting_scope)


      respond_to do |format|
        format.html
        format.json {
          render json: { filters: @filters, html: render_to_string(partial: 'shop_body.html.erb', locals: { sort: params[:sorting] }) }
        }
      end
    end

    def sorting_param
      params[:sorting].try(:to_sym) || default_sorting
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

    private

    def sorting_scope
      allowed_sortings.include?(sorting_param) ? sorting_param : default_sorting
    end

    def default_sorting
      :ascend_by_updated_at
    end

    def allowed_sortings
      [:descend_by_master_price, :ascend_by_master_price, :ascend_by_updated_at]
    end

end