// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require popper
//= require twitter/bootstrap
//= require turbolinks
//= require_tree .


function increaseValue() {
    var value = parseInt(document.getElementById('qty').value, 10);
    value = isNaN(value) ? 0 : value;
    value++;
    document.getElementById('qty').value = value;
  }
  
  function decreaseValue() {
    var value = parseInt(document.getElementById('qty').value, 10);
    value = isNaN(value) ? 0 : value;
    value < 1 ? value = 1 : '';
    value--;
    document.getElementById('qty').value = value;
  }

  function openURL(url){
    document.location.href = url;
  }