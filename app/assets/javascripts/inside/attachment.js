
//送信者絞込みのセレクトボックスの選択イベント情報の取得
$(document).ready(function(){
  $('#select_sender').change(function(){
    location.href = '/attachment?sender='+$(this).val();
  });
});

//検索窓からの情報の取得
$(document).ready(function(){
  $('#file_search').keypress(function(e){
    if((e.which && e.which == 13) || (e.keyCode && e.keyCode == 13)){
      location.href = '/attachment?search=' + $(this).val();
    }
  });
});

