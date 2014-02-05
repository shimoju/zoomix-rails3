$(function() {
  //$('.player #caption').hide();
  //$('#player #caption').click(function() {
  //  $(this).slideUp();
  //});

  $('.play').click(function() {
    window.open('play', '', 'width=480,height=400');
    return false;
  });
});


var content_id;

var player;
function onYouTubeIframeAPIReady() {
  player = new YT.Player('content', {
    height: '315',
    width: '560',
    //videoId: '9_ifx-Dmv9g',
    playerVars: { 'autoplay': 1, 'rel': 0 },
    events: {
      'onReady': onPlayerReady,
      'onStateChange': onPlayerStateChange
    }
  });
}

function onPlayerReady(event) {
  $.getJSON('/play/current.json', function(data) {
    event.target.loadVideoById(data['content']['cid']);

    content_id = data['content']['id']
    time = new Date(data['post']['posted_at']);
    user_html = '<span class="name">'+data['post']['name']+'</span> <span class="username">@'+data['post']['username']+'</span>';
    text_html = data['post']['text'];
    time_html = time.toLocaleString();
    //caption_html = '<div>'+data['post']['name']+'（@'+data['post']['username']+'）さんが投稿しました：'+'</div><div>'+data['post']['text']+'</div>';
    //$('#caption').html(caption_html)//.delay(1200).fadeIn().delay(5000).fadeOut();
    $('#user').html(user_html);
    $('#text').html(text_html);
    $('#time').html(time_html);
    //$('#caption').delay(1200).fadeIn().delay(5000).fadeOut();
    //$('#caption').delay(1200).slideDown().delay(5000).slideUp();
  });

  //event.target.playVideo();
}

function onPlayerStateChange(event) {
  if ( event.data == YT.PlayerState.ENDED ) {
    $.getJSON('/play/next.json', {'content_id': content_id}, function(data) {
      event.target.loadVideoById(data['content']['cid']);

      content_id = data['content']['id'];
      caption_html = '<div>'+data['post']['name']+'（@'+data['post']['username']+'）さんが投稿しました：'+'</div><div>'+data['post']['text']+'</div>';
      $('#caption').html(caption_html)//.delay(1200).fadeIn().delay(5000).fadeOut();
    });
    //event.target.loadVideoById("9_ifx-Dmv9g");
  }
}
