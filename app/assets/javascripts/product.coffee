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

    $('.weltpixel-quickview').bind 'click', ->
      prodUrl = $(this).attr('data-quickview-url')
      if prodUrl.length
        quickview.displayContent prodUrl
      return

  $(".sw-megamenu").swMegamenu();
  $('.gallery-placeholder').fotorama();

window.weltpixel_quickview =
  'baseUrl': 'http://www.newsmartwave.net/magento2/porto/demo4_en/'
  'closeSeconds': '5'
  'showMiniCart': '1'
  'showShoppingCheckoutButtons': '1'