if (window.matchMedia( "(min-width: 1070px)" ).matches) {

    // alert('1070px以上です');
    $('footer-cell_mercari').css({'color':'blue','font-size':'20px'});
}else{
    // alert('1070px以下です');
    $('footer-cell').removeClass('.on');
}
