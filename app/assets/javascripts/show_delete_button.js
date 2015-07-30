function hideStuff(){
  $('.keyword_li').children().mouseenter(function(){
   $(this).children().find('input').css('visibility','visible');
 })
  $('.keyword_li').children().mouseleave(function(){
   $(this).children().find('input').css('visibility','hidden');
  })
};


$(document).ready(function(){
  hideStuff();
})