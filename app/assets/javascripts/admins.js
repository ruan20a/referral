$(document).ready(function(){

  $('a[href="#all-referrals"]').on("click", function(){
    $('#pending-referrals').removeClass("active in")
  });


  $('a[href="#pending-referrals"]').on("click", function(){
    $('#all-referrals').removeClass("active in")
    $('#pending-referrals').addClass("active in")
  });

  $('.admin-pending').on("click", function(){
    $('#all-referrals').removeClass("active in")
    $('#pending-referrals').addClass("active in")
  });


})

