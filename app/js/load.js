head.load([{
  'jq': 'http://code.jquery.com/jquery-1.11.1.min.js'
}, {
  'lazy': 'https://raw.github.com/tuupola/jquery_lazyload/master/jquery.lazyload.js'
}, {
  'bs': '//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js'
}, {
  'app': '/js/app.js'
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
    if (/photography/.test(window.location.href)) {
      $(".pic img").lazyload({
        effect: "fadeIn"
      });
    }

    if (/guestbook/.test(window.location.href)) {
      Brotherus.instances.guestbook = new Brotherus.Guestbook();
    }

  });

});