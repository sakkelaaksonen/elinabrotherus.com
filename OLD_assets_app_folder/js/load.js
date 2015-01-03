head.load([{
  'jq': 'http://code.jquery.com/jquery-1.11.1.min.js'
}, {
  'lazy': 'https://raw.github.com/tuupola/jquery_lazyload/master/jquery.lazyload.js'
}, {
  'bs': '//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js'
}, {
  'cookie': "/js/jquery.cookie.js"
}, {
  'scroll': "/js/jquery.scrollTo-1.4.2-min.js"
}, {
  'form': "/js/jquery.form.js"
}, {
  'gb': "/js/brotherus.guestbook.js"
}]);

head.ready(function() {
  //jq onload
  $(function() {

    var location = window.location.href;

    if (/photography/.test(location)) {
      $(".pic img").lazyload({
        effect: "fadeIn"
      });
    }

    if (/guestbook/.test(location)) {
      Brotherus.instances.guestbook = new Brotherus.Guestbook();
    }

  });

});