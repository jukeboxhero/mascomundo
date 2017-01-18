$ ->
  $('.main .products.grid .product-items li.product-item:nth-child(2n)').addClass('nth-child-2n');
  $('.main .products.grid .product-items li.product-item:nth-child(2n+1)').addClass('nth-child-2np1');
  $('.main .products.grid .product-items li.product-item:nth-child(3n)').addClass('nth-child-3n');
  $('.main .products.grid .product-items li.product-item:nth-child(3n+1)').addClass('nth-child-3np1');
  $('.main .products.grid .product-items li.product-item:nth-child(4n)').addClass('nth-child-4n');
  $('.main .products.grid .product-items li.product-item:nth-child(4n+1)').addClass('nth-child-4np1');
  $('.main .products.grid .product-items li.product-item:nth-child(5n)').addClass('nth-child-5n');
  $('.main .products.grid .product-items li.product-item:nth-child(5n+1)').addClass('nth-child-5np1');
  $('.main .products.grid .product-items li.product-item:nth-child(6n)').addClass('nth-child-6n');
  $('.main .products.grid .product-items li.product-item:nth-child(6n+1)').addClass('nth-child-6np1');
  $('.main .products.grid .product-items li.product-item:nth-child(7n)').addClass('nth-child-7n');
  $('.main .products.grid .product-items li.product-item:nth-child(7n+1)').addClass('nth-child-7np1');
  $('.main .products.grid .product-items li.product-item:nth-child(8n)').addClass('nth-child-8n');
  $('.main .products.grid .product-items li.product-item:nth-child(8n+1)').addClass('nth-child-8np1');

  $('.filter-options .items .item').on 'click', (e) ->
    unless $(e.target).hasClass('property')
      e.preventDefault()
      checkBoxes = $(this).find("input.property[type='checkbox']");
      checkBoxes.prop("checked", !checkBoxes.prop("checked"));
    activateFilter();

  $('body').on 'click', '.applied-filters .action.remove', (e) ->
    removeFilter($(this).data('filter'));

  $('.filter-options-title').click ->
    $(this).parent().toggleClass('active');

  $('.page-products').on 'click', '.modes #mode-list', (e) ->
    e.preventDefault();
    activateListMode();

  $('.page-products').on 'click', '.modes #mode-grid', (e) ->
    e.preventDefault();
    activateGridMode();

  $('.filter-current').on 'click', 'li.item .action.remove', (e) ->
    e.preventDefault();

  $('.filter-actions').on 'click', '.action.clear', (e) ->
    e.preventDefault();
    clearFilters();

  $('body').on 'change', '.toolbar-sorter #sorter', ->
    activateFilter()

  activateListMode = =>
    toggleListMode('list');

  activateGridMode = =>
    toggleListMode('grid');

  activateFilter = =>
    $("#ln_overlay").show();
    url = window.location.href.split('?')[0] + '?' + $("#property_form").serialize();
    attrChar = ''
    attrChar = '&' if $("#property_form").serialize().length > 0
    url += attrChar + "sorting=" + $('#sorter').val()
    $.get url, ((data) ->
      $("#ln_overlay").hide();
      output = ''
      $.each data.filters, (key, value) ->
        output += "<li class='item'><span class='filter-label'>#{key}</span><span class='filter-value'>#{value.join(', ')}</span><a class='action remove' data-filter='#{key}' href='#' title='Remove #{key}'>
                            <span>Remove This Item</span>
                        </a></li>"
        return
      # hide the current filter box if none are applied
      if $.isEmptyObject data.filters
        $('.applied-filters').hide()
      else
        $('.applied-filters').show()
      $('#maincontent .column.main').html(data.html)
      $('.filter-current ol.items').html(output)
      
      window.history.pushState({}, "", url);
      return
    ), 'json'

  removeFilter = (filter) =>
    $('.filter-options[data-property="' + filter + '"]').find('.items .item input:checkbox').removeAttr('checked')
    activateFilter()

  clearFilters = =>
    $('.filter-options .items .item input:checkbox').removeAttr('checked')
    activateFilter()

  toggleListMode = (mode) ->
    $('.modes-mode').removeClass('active');
    $('.mode-' + mode).addClass('active');
    wrapper = $('#layer-product-list').find('.products.wrapper')
    wrapper.removeClass('grid list products-grid products-list');
    wrapper.addClass(mode + ' products-' + mode);