//ユーザー選択情報の取得
$(document).ready(function(){
  gi = $('#gi').val(); 
  $('#select_user').change(function(){
    location.href = '/facebook/group/' + gi + '?u=' + $(this).val();
  }); 
});

//日付選択情報の取得
$(document).ready(function(){
  gi = $('#gi').val(); 
  $('#datepicker').change(function(){
    location.href = '/facebook/group/' + gi + '?dt=' + $(this).val();
  }); 
});

//検索窓からの情報の取得
$(document).ready(function(){
  gi = $('#gi').val(); 
  $('#posts_search').keypress(function(e){
    if((e.which && e.which == 13) || (e.keyCode && e.keyCode == 13)){
      location.href = '/facebook/group/' + gi + '?q=' + $(this).val();
    }   
  }); 
});
