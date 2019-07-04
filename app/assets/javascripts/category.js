$(function(){
  function appendOption(category){
    var html = `<option value="${category.name}">${category.name}</option>`;
    return html;
  }
  function appendChidrenBox(insertHTML){
    var childSelectHtml = '';
    childSelectHtml = `<div class='listing-select-wrapper__added' id= 'children_wrapper'>
                        <div class='listing-select-wrapper__box'>
                        <select class="listing-select-wrapper__box--select" id="child_category" name="prefecture">
                          <option value="---">---</option>
                          ${insertHTML}
                        <select>
                        <i class='fas fa-chevron-down listing-select-wrapper__box--arrow-down'></i>`;
    $('.listing-product-detail__category').append(childSelectHtml);
  }
  function appendGrandchidrenBox(insertHTML){
    var grandchildSelectHtml = '';
    grandchildSelectHtml = `<div class='listing-select-wrapper__added' id= 'grandchildren_wrapper'>
                              <div class='listing-select-wrapper__box'>
                              <select class="listing-select-wrapper__box--select" id="grandchild_category" name="prefecture">
                                <option value="---">---</option>
                                ${insertHTML}
                              <select>
                              <i class='fas fa-chevron-down listing-select-wrapper__box--arrow-down'></i>`;
    $('.listing-product-detail__category').append(grandchildSelectHtml);
  }
  $('#parent_category').on('change', function(){
    var parentCategory = document.getElementById('parent_category').value;
    $.ajax({
      url: 'get_category_children',
      type: 'GET',
      data: { parent_name: parentCategory },
      dataType: 'json'
    })
    .done(function(children){
      $('#children_wrapper').remove();
      $('#grandchildren_wrapper').remove();
      var insertHTML = '';
      children.forEach(function(child){
        insertHTML += appendOption(child);
      });
      appendChidrenBox(insertHTML);
    })
    .fail(function(){
      $('#children_wrapper').remove();
      $('#grandchildren_wrapper').remove();
    })
  });

  $('.listing-product-detail__category').on('change', '#child_category', function(){
    var childCategory = document.getElementById('child_category').value;
    console.log(childCategory);
    $.ajax({
      url: 'get_category_grandchildren',
      type: 'GET',
      data: { child_name: childCategory },
      dataType: 'json'
    })
    .done(function(grandchildren){
      if (grandchildren.length != 0) {
        $('#grandchildren_wrapper').remove();
        var insertHTML = '';
        grandchildren.forEach(function(grandchild){
          insertHTML += appendOption(grandchild);
        });
        appendGrandchidrenBox(insertHTML);
      }
    })
    .fail(function(){
      $('#grandchildren_wrapper').remove();
    })
  });
});