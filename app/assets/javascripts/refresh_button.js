$(document).ready(function(){

  var dots;

  $("#loading").hide();
  setInterval(addDots, 250);

  $('form.button_to input[type="submit"]').on("click",function(){
    $(this).hide();
    $("#loading").show();
  })
})

function addDots(){
  if(dots < 3){
    $("#dots").append('.');
      dots++;
    }
  else{
    $("#dots").empty();
      dots = 0;
    }
  };