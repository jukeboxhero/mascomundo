module ApplicationHelper
  def nav_breadcrumbs(taxon, separator="", breadcrumb_class="items")
    return "" if current_page?("/") || taxon.nil?

    crumbs = [[Spree.t(:home), spree.root_path]]

    if taxon
      crumbs << [Spree.t(:products), products_path]
      crumbs += taxon.ancestors.collect { |a| [a.name, spree.nested_taxons_path(a.permalink)] } unless taxon.ancestors.empty?
      crumbs << [taxon.name, spree.nested_taxons_path(taxon.permalink)]
    else
      crumbs << [Spree.t(:products), products_path]
    end

    separator = raw(separator)

    crumbs.map! do |crumb|
      content_tag(:li, class:"item", itemtype:"http://data-vocabulary.org/Breadcrumb") do
        link_to(crumb.last, itemprop: "url") do
          content_tag(:span, crumb.first, itemprop: "title")
        end + (crumb == crumbs.last ? '' : separator)
      end
    end

    content_tag(:div, content_tag(:ul, raw(crumbs.map(&:mb_chars).join), class: breadcrumb_class), id: 'breadcrumbs', class: 'breadcrumbs')
  end
end
