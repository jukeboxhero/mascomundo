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

  $('.filter-options-title').click ->
    $(this).parent().toggleClass('active');

  $('.page-products').find('.modes #mode-list').on 'click', (e) ->
    e.preventDefault();
    activateListMode();

  $('.page-products').find('.modes #mode-grid').on 'click', (e) ->
    e.preventDefault();
    activateGridMode();

  activateListMode = =>
    toggleListMode('list');

  activateGridMode = =>
    toggleListMode('grid');

  toggleListMode = (mode) ->
    $('.modes-mode').removeClass('active');
    $('.mode-' + mode).addClass('active');
    wrapper = $('#layer-product-list').find('.products.wrapper')
    wrapper.removeClass('grid list products-grid products-list');
    wrapper.addClass(mode + ' products-' + mode);