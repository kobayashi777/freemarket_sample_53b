
$(function() {
  
  // var setThumbId = '.content--photo-down';   この3行は軌跡として残したい
  // var connectCont = $(setThumbId + ' li').index(this);
  // var connectCont1 = $('.content-photo-down__piece').index(this)

  $('.content-photo-down__piece').mouseover(function(){

    var ind = $('.content--photo-down').children('li').index(this);
    var ind2 = $('.content--photo-up').children('li').index(this);

    if (ind != ind2/*%10*/) {   /* この左の条件分岐必要ないと思われるが何かの為に残しておく */
      if (ind2/*%10*/ <= ind) { /* %10は.content--photo内の<li>の順番が０〜１９までの時にphoto-upとphoto-downの区別をつけるために使用 下記の%10も同様 */
        $('.content--photo-up').stop().animate({left: -(ind/*%10*/)*300}, 500)  /* indの数だけ(０~9) width: 300px; 左に動かす。 */
      } else {
        $('.content--photo-up').stop().animate({left: (ind/*%10*/)*300}, 500)   /* indの数だけ(０~9) width: 300px; 右に動かす。 */
      }
    };
  });
});