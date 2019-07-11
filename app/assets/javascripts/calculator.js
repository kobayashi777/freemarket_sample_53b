// 商品購入ページのの利益計算機能
$(document).on('turbolinks:load', function() { 
  $(function(){
    $("#price-form").keyup(function(){

    var salesDesiredPrice = $(this).val();
    var salesFee = Math.floor(salesDesiredPrice * 0.1);
    var salesProfit = Math.floor(salesDesiredPrice - salesFee);
    
    // 価格設定300円〜9,999,999円
    if (salesDesiredPrice > 299 && salesDesiredPrice < 10000000 ) {
      $("#sf-tag").text("¥" + salesFee.toLocaleString('ja-JP'));
      $("#sp-tag").text("¥" + salesProfit.toLocaleString('ja-JP'));
    } else {
      $("#sf-tag").text("-");
      $("#sp-tag").text("-");
    }
    });
  });
});
