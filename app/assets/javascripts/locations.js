$( document ).ready(function() {
  $('#locations').dataTable({
    "bScrollInfinite": true,
    "bScrollCollapse": true,
    "sScrollY": "700px",
    "iDisplayLength": 100,

    "aoColumnDefs": [
      { "bSearchable": true, "bVisible": false, "aTargets": [ 1 ] },
      { "bSearchable": true, "bVisible": false, "aTargets": [ 2 ] },
      { "bSearchable": true, "bVisible": false, "aTargets": [ 3 ] }
    ]
  }); 
});
