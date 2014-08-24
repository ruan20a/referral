$(document).ready(function(){
  $(".company").click(function(){
    window.location = this.getAttribute("data-companyurl");
  });

  // figure out max height
  var heights = $(".company").map(function() {
        return $(this).height();
  }).get(),

  maxHeight = Math.max.apply(null, heights);

  $(".company").height(maxHeight);
});
