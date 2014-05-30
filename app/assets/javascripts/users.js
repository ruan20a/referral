$(document).ready(function(){

  $('a[href="#received-referrals"]').on("click", function(){
    $('#sent-referrals').removeClass("active in")
  });


  $('a[href="#sent-referrals"]').on("click", function(){
    $('#received-referrals').removeClass("active in")
    $('#sent-referrals').addClass("active in")
  });


})

