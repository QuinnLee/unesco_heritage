// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require pickadate/picker
//= require pickadate/picker.date 
//= require twitter/bootstrap
//= require_tree .

$(document).ready(function(){
  $(".log_entry_date").pickadate({
    selectYears: 30,
  });

  $(".plan_entry_date").pickadate({
    selectYears: 30,
  });

  $("a.location").hover(function(){
    var data = $(event.target).data();
    var lat = data.lat;
    var lng = data.long;
    var latlng = new google.maps.LatLng(lat, lng);
    // Gmaps.map.serviceObject.setZoom(1);
    Gmaps.map.serviceObject.panTo(latlng);
    Gmaps.map.serviceObject.setZoom(8);
  });
  $("a.mark").hover(function(){
    var data = $(event.target).data();
    var lat = data.lat;
    var lng = data.long;
    var latlng = new google.maps.LatLng(lat, lng);
    var marker = new google.maps.Marker({
      position: latlng,
      map: Gmaps.map.serviceObject
    });
  });



});

