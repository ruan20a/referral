//jQuery to collapse the navbar on scroll
$(window).scroll(function() {
    if ($(".navbar-header").offset().top > 50) {
        $(".navbar-fixed-top").addClass("top-nav-collapse");
    } else {
        $(".navbar-fixed-top").removeClass("top-nav-collapse");
    }
});

//jQuery for page scrolling feature - requires jQuery Easing plugin
$(function() {
    $('.page-scroll a').bind('click', function(event) {
        var $anchor = $(this);
        $('html, body').stop().animate({
            scrollTop: $($anchor.attr('href')).offset().top
        }, 1500, 'easeInOutExpo');
        event.preventDefault();
    });
});

jQuery('.data-table').each(function() {
    var thetable=jQuery(this);
    jQuery(this).find('tbody td').each(function() {
        jQuery(this).attr('data-heading',thetable.find('thead th:nth-child('+(jQuery(this).index()+1)+')').text());
    });
});