# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->

  submitHandler: (form) ->
    widget = $(form).catalogAddToCart(bindSubmit: false)
    widget.catalogAddToCart 'submitForm', $(form)
    false

  loaded = false
  $('.product.media .gallery-placeholder').bind 'DOMSubtreeModified', ->
    $('.product.media .fotorama').on 'fotorama:ready', (e, fotorama, extra) ->
      loaded = false
      $('.product.media .fotorama').on 'fotorama:load', (e, fotorama, extra) ->
        if !loaded
          $('.product.media .fotorama__stage .fotorama__loaded--img').trigger 'zoom.destroy'
          $('.product.media .fotorama__stage .fotorama__active').zoom touch: false
          loaded = true
        return
      $('.product.media .fotorama').off('fotorama:showend').on 'fotorama:showend', (e, fotorama, extra) ->
        $('.product.media .fotorama__stage .fotorama__loaded--img').trigger 'zoom.destroy'
        $('.product.media .fotorama__stage .fotorama__active').zoom touch: false
        return
      $('.fotorama').off('fotorama:fullscreenenter').on 'fotorama:fullscreenenter', (e, fotorama, extra) ->
        $('.product.media .fotorama__stage .fotorama__loaded--img').trigger 'zoom.destroy'
        $('img.zoomImg').remove()
        return
      $('.fotorama').off('fotorama:fullscreenexit').on 'fotorama:fullscreenexit', (e, fotorama, extra) ->
        $('.product.media .fotorama__stage .fotorama__loaded--img').trigger 'zoom.destroy'
        $('img.zoomImg').remove()
        $('img.fotorama__img').not('.fotorama__img--full').each ->
          $(this).after $(this).parent().children('img.fotorama__img--full')
          return
        $('.product.media .fotorama__stage .fotorama__active').zoom touch: false
        $('.product.media .fotorama').off('fotorama:showend').on 'fotorama:showend', (e, fotorama, extra) ->
          $('.product.media .fotorama__stage .fotorama__loaded--img').trigger 'zoom.destroy'
          $('.product.media .fotorama__stage .fotorama__active').zoom touch: false
          return
        return
      return
    return

    $('#custom-owl-slider-product.owl-carousel').owlCarousel
    items: 1
    lazyLoad: true

    $('.weltpixel-quickview').on 'click', ->
      prodUrl = $(this).attr('data-quickview-url')
      if prodUrl.length
        quickview.displayContent prodUrl
      return

  $(".sw-megamenu").swMegamenu();
  $('.gallery-placeholder').fotorama();

  $('.qty-inc').on 'click', ->
    field = $(this).closest('.qty').find('input.qty')
    field.val(parseInt(field.val()) + 1)

  $('.qty-dec').on 'click', ->
    field = $(this).closest('.qty').find('input.qty')
    field.val(parseInt(field.val()) - 1) if field.val() > 1

  $('.tocart').on 'click', ->
    $(this).prop('disabled', true)
    $(this).html('Adding...')

    url = $(this).closest('form').attr('action')
    $.ajax(
      url: url
    ).fail(->
      alert('error');
    ).done (data) =>
      $(this).html('Added')
      setTimeout(=>
        $(this).prop('disabled', false)
        $(this).html('Add to Cart')
        $('.message-success').removeClass('hide')
        $('#added-notice').modal();
      , 2000)
      return

  $("#added-notice .action-close, .action.primary.continue").on 'click', ->
    $('#added-notice').modal('hide');

  $(".action.primary.checkout").on 'click', ->
    url = $(this).data('url')
    window.open(url,'_parent');

  $('.product.data.items').find('.data.item.title').on 'click', (e) ->
    e.preventDefault()
    $('.product.data.items').find('.data.item.content').hide()
    $('.product.data.items').find('.data.item.title.active').removeClass('active')
    $(this).addClass('active')
    id = $(this).attr('id')
    tabpanel = $('[aria-labelledby="' + id + '"]')
    tabpanel.show()

window.weltpixel_quickview =
  'baseUrl': 'http://www.newsmartwave.net/magento2/porto/demo4_en/'
  'closeSeconds': '5'
  'showMiniCart': '1'
  'showShoppingCheckoutButtons': '1'