var enable_quickview = true;

displayContent = function(prodUrl) {
    if (!prodUrl.length) {
        return false;
    }

    var url = window.weltpixel_quickview.baseUrl + 'weltpixel_quickview/index/updatecart';
    var showMiniCart = parseInt(window.weltpixel_quickview.showMiniCart);

    window.weltpixel_quickview.showMiniCartFlag = false;

    $.magnificPopup.open({
        items: {
          src: prodUrl
        },
        type: 'iframe',
        closeOnBgClick: false,
        preloader: true,
        tLoading: '',
        callbacks: {
            open: function() {
              $('.mfp-preloader').css('display', 'block');
              $('.mfp-content').css({width: '100%', height: '708px'});
            },
            beforeClose: function() {
                $('[data-block="minicart"]').trigger('contentLoading');
                $.ajax({
                url: url,
                method: "POST"
              });
            },
            close: function() {
              $('.mfp-preloader').css('display', 'none');
            },
            afterClose: function() {
                /* Show only if product was added to cart and enabled from admin */
                if (window.weltpixel_quickview.showMiniCartFlag && showMiniCart) {
                    $("html, body").animate({ scrollTop: 0 }, "slow");
                    setTimeout(function(){
                        $('.action.showcart').trigger('click');
                    }, 1000);
                }
            },
            markupParse: function(template, values, item) {
                console.log('Parsing:', template, values, item);
                console.log($('.mfp-iframe'));
                setTimeout(function() {
                    $('.mfp-iframe').css('opacity', '1');
                    $('.mfp-iframe').css('display', 'block');
                    $('.mfp-preloader').css('display', 'none');
                }, 500);
            },
          }
    });
}
