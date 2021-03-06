// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

// dropdown button
$(document).ready(function(){
  $('.dropdown-button').dropdown({
      inDuration: 300,
      outDuration: 225,
      constrain_width: false,
      hover: true,
      gutter: 0,
      belowOrigin: false
  });
     
  $(".button-collapse").sideNav();
  $('.parallax').parallax();
  $('select').material_select();
});

$(document).ready(function(){

  var $developers = $('.developer');

  $('#developer_filter_name').on('keyup', function () {
    var currentName = this.value.toUpperCase();
    $developers.each(function (index, developer) {
      var $developer = $(developer);
      if ($developer.data('name').indexOf(currentName) >= 0) {
        $developer.show();
      }
      else {
        $developer.hide();
      }
    });
  });
}); 