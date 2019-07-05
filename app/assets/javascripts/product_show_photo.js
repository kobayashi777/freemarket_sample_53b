// $(document).on('turbolinks: reload', function(){
//   $('.content-photo-down__piece').mouseover(function(e) {
//     //var src = $(this).children.attr("src", )
//     console.log('here i am');
//   });
// });    この表記効きません


// $(function() {
//   $('.content-photo-down__piece').mouseover(function(e) {
//     //console.log('here i am');  checking fire
//     //console.log($(this).children('src'));
//     var srcdown = $(this).children('img').attr('src');    // mouseover時の重ねた写真のurl/srcを取得
//     //console.log(srcdown);
//     $('.content--photo-up').attr('src', srcdown);
//     //console.log(this);  check
//     //$('.content--photo-up').child(src).attr('src');  // mouseover時に上の写真を取り除くきたい
//   });
// });      保留  残骸１
  

// $(function(){
//   var setMainId = '.content--photo-up';
//   var setThumbId = '.content--photo-down';
//   var slideTime = 500;
//   var delayTime = 5000;

//   $(setMainId).each(function(){
//       var sliderWidth = $(this).width();    // ここは300と出る
//       var sliderHeight = $(this).height();  // ここは300と出る

//       var listWidth = parseInt($(this).children('li').css('width'), 10);
//       var listCount = $(this).children('li').length;    /* 上記とこれ .children('photo-up-piece') だと効かず */

//       //console.log($(this).children('ul').children('li').css('width'));
//           //  ⬆︎undefined     実験 確かめるために
//       var ulWidth = (listWidth)*(listCount);
//       // console.log(listWidth);   
//       // console.log(listCount); 
//       // console.log(ulWidth);     

//       $(setMainId).css({
//           width: (ulWidth),
//           height: (sliderHeight),
//          // overflow: (hidden)      // hidden is undefined.
//          // $(setMainId).style.overflow: 'hidden';  unacceptable syntax これエラー文ではありません
//           'overflow': 'hidden'  // 書くと写真出てくる
//       });

//       $(setThumbId + ' li:first').addClass('active');
//       $(setThumbId + ' li').css({opacity:'0.5'});

//       $(setThumbId + ' li').hover(function(){
         
//           $(this).stop().animate({opacity:'1'},300);
//           var ind = $('li').index(this);    // up含めて<li>要素がカウントされている
//           var connectCont = $(setThumbId + ' li').index(this);
//           // console.log(connectCont); //downの<li>要素が0からカウントされている */
           
//           var srcup = $('.photo_up').children('img').attr('src');   // 上の画像のURL取得
//           var srcdown = $('.content-photo-down__piece').eq(ind).find('img').attr('src');  // 下の画像のURL取得

//           if (srcup != srcdown) { // 画像が異なるかで場合分け
//             console.log((sliderWidth)*(connectCont)); // 300の倍数 300*<li>に振り分けられた数  */
//             if ( (300*ind)>=(sliderWidth)*(connectCont) ) {   // {上の画像の数(画像に数字を振り分けている) >= 下の画像の数(画像に数字を振り分けている)}
//                $(setMainId + ' li').animate({left:40},slideTime);
//              }
//           }
//           $(setMainId + ' li').animate({left:(sliderWidth)*(connectCont)},slideTime);
          
//           $(setThumbId + ' li').removeClass('active');
//           $(this).addClass('active');
//       },function(){
//           $(this).stop().animate({opacity:'0.5'},300);
         
//       });
//     });
//   });        保留その３  最有力候補


// $(function() {
//   $('.content-photo-down__piece').mouseover(function() {
//     //$($('.content--photo-up').children).attr('src', $(this).attr('src'));
//     //$('#photo_up').attr('src', $(this).attr('src'));
//     //console.log($('#photo_up').attr('src'));
//     //console.log($(this).attr('src'));
//     // console.log(this); メンター実験
//     //console.log($(this img).attr(src));
//     // <li>要素の順番を変数に格納
//     var ind = $('li').index(this);
  
//     // 変数の中身をコンソールに表示
 
//     console.log(ind);
//     // console.log($('.photo_up').children('img').attr('src'));  // mouseover時の画像 up  のURL取得
//     console.log($('.content-photo-down__piece').eq(ind).find('img').attr('src'));   // mouseoverした画像downのURL取得
    
//     var srcup = $('.photo_up').children('img').attr('src');
//     var srcdown = $('.content-photo-down__piece').eq(ind).find('img').attr('src');
//     // console.log(srcup);
//     // console.log(srcdown);
//     if (srcup != srcdown) {
//       $('.photo_up').children('img').attr('src', srcdown);
//     };
    
//     var srcup2 = $('.content--photo-up').children('img').attr('src');
//     if (srcup2 != srcdown) {
//       $('.content--photo-up')
//     }
//   });
//   // $('.content--photo-up').mouseover(function(){
//   //   console.log('aaaaaaaa');
//   //   console.log($('.photo_up').children('img').attr('src'));
//   // });      これは実験
// });           保留その２ 残骸２



/* これはanimateの実験 検証作業用 ＝＞ 本番になった   ここから上のコメントは軌跡として残す */
$(function() {
  
  // var setThumbId = '.content--photo-down';   この3行は軌跡として残したい
  // var connectCont = $(setThumbId + ' li').index(this);
  // var connectCont1 = $('.content-photo-down__piece').index(this)

  $('.content-photo-down__piece').mouseover(function(){

    var ind = $('.content--photo-down').children('li').index(this);
    var ind2 =$('.content--photo-up').children('li').index(this);
    console.log(ind)
    console.log(ind2)
    if (ind != ind2/*%10*/) {   /* この左の条件分岐必要ないと思われるが何かの為に残しておく */
      if (ind2/*%10*/ <= ind) { /* %10は.content--photo内の<li>の順番が０〜１９までの時にphoto-upとphoto-downの区別をつけるために使用 下記の%10も同様 */
        $('.content--photo-up').stop().animate({left: -(ind/*%10*/)*300}, 500)  /* indの数だけ(０~9) width: 300px; 左に動かす。 */
      } else {
        $('.content--photo-up').stop().animate({left: (ind/*%10*/)*300}, 500)   /* indの数だけ(０~9) width: 300px; 右に動かす。 */
      }
    };
  });
});