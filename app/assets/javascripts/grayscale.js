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


// Focus state for append/prepend inputs
   $('.input-group').on('focus', '.form-control', function () {
     $(this).closest('.input-group, .form-group').addClass('focus');
   }).on('blur', '.form-control', function () {
     $(this).closest('.input-group, .form-group').removeClass('focus');
   });
});

jQuery('.data-table').each(function() {
    var thetable=jQuery(this);
    jQuery(this).find('tbody td').each(function() {
        jQuery(this).attr('data-heading',thetable.find('thead th:nth-child('+(jQuery(this).index()+1)+')').text());
    });
});


// -----------AMY SOCIAL SHARE STUFF-------------- //
$( document ).ready(function() {

  // (function(d, s, id) {
  //   var js, fjs = d.getElementsByTagName(s)[0];
  //   if (d.getElementById(id)) return;
  //   js = d.createElement(s); js.id = id;
  //   js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.0";
  //   fjs.parentNode.insertBefore(js, fjs);
  // }(document, 'script', 'facebook-jssdk'));


  $('.social-share').click(function(e){
    e.preventDefault();
    // alert("reagegagea");
    var url = $(this).attr("data-url");
    var title = $(this).attr("data-title");
    var desc = $(this).attr("data-desc");
    var height = $(this).attr("data-height");
    var width = $(this).attr("data-width");
    var social = $(this).attr("data-share");
    socialShare(url, title, desc, height, width, social)
  });

  function socialShare(url, title, descr, winHeight, winWidth, social) {
        var winTop = (screen.height / 2) - (winHeight / 2);
        var winLeft = (screen.width / 2) - (winWidth / 2);
        switch (social) {
          case (social = "facebook"):
            window.open('http://www.facebook.com/sharer.php?s=100&p[title]=' + title + '&p[summary]=' + descr + '&p[url]=' + url, 'top=' + winTop + ',left=' + winLeft + ',toolbar=0,status=0,scrollbars=no,location=no,directories=no,resizable=yes,width=' + winWidth + ',height=' + winHeight);
            break;
          case (social = "twitter"):
            window.open("http://twitter.com/home?status=" + title + " - " + url)
            break;
          case (social = "linkedin"):
            window.open("http://www.linkedin.com/shareArticle?mini=true&url=" +url +"&title=" + title)
            break;
        }return false
  }
});

// -----------AMY SOCIAL SHARE STUFF-------------- //
