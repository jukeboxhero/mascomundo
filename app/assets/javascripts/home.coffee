# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->

  beginNewsletterForm = ->
    $.fancybox
      'padding': '0px'
      'autoScale': true
      'transitionIn': 'fade'
      'transitionOut': 'fade'
      'type': 'inline'
      'href': '#newsletter_popup'
      'onComplete': ->
        $.cookie 'newsletter_popup', 'shown'
        return
      'tpl': closeBtn: '<a title="Close" class="fancybox-item fancybox-close fancybox-newsletter-close" href="javascript:;"></a>'
      'helpers': overlay: locked: false
    $('#newsletter_popup').trigger 'click'
    return

  $(document).ready ->
    if $('body').hasClass('cms-index-index')
      check_cookie = $.cookie('newsletter_popup')
      if window.location != window.parent.location
        $('#newsletter_popup').remove()
      else
        if check_cookie == null or check_cookie == 'shown'
          setTimeout (->
            beginNewsletterForm()
            return
          ), 5000
        $('#newsletter_popup_dont_show_again').on 'change', ->
          `var check_cookie`
          if $(this).length
            check_cookie = $.cookie('newsletter_popup')
            if check_cookie == null or check_cookie == 'shown'
              $.cookie 'newsletter_popup', 'dontshowitagain'
            else
              $.cookie 'newsletter_popup', 'shown'
              beginNewsletterForm()
          else
            $.cookie 'newsletter_popup', 'shown'
          return

      href = $('.header.links .authorization-link > a').attr('href')

    if href.indexOf('logout') == -1
      $('.block-header-customer-login').detach().appendTo '.authorization-link'
      $('.block-header-customer-login').click (e) ->
        e.stopPropagation()
        return
      $('html,body').click ->
        if $('.block-header-customer-login').hasClass('open')
          $('.block-header-customer-login').removeClass 'open'
        return
      $('.header.links .authorization-link > a').off('click').on 'click', ->
        if !$('.block-header-customer-login').hasClass('open')
          $('.block-header-customer-login').addClass 'open'
        else
          $('.block-header-customer-login').removeClass 'open'
        false
    return
  return

