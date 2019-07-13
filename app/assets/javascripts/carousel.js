$(document).on('turbolinks:load', function() {
  $(function(){
    $('.slick').slick({
      // autoplay:true,
      speed: 1000,
      dots:true,
      pauseOnHover: true,
    });
    $( '.slick' ).on( 'mouseenter', 'li', function() {
      $( this ).click();
      } );
  });
});




