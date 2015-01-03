head.load([{
  'jq': 'http://code.jquery.com/jquery-1.11.1.min.js'
}, {
  'lazy': 'https://raw.github.com/tuupola/jquery_lazyload/master/jquery.lazyload.js'
}, {
  'bs': '//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js'
}, {
  'cookie': "/javascripts/jquery.cookie.js"
}, {
  'scroll': "/javascripts/jquery.scrollTo-1.4.2-min.js"
}, {
  'form': "/javascripts/jquery.form.js"
}, {
  'gb': "/javascripts/brotherus.guestbook.js"
}]);

head.ready(function() {
  //jq onload
  $(function() {

    var location = window.location.href;

    if (/photography/.test(location)) {
      $(".pic img").lazyload({
        effect: "fadeIn"
      })


      //prevent context menu from relevant images
      $(document).on("contextmenu", ".pic img, img.pic, .thumb-link", function(event) {
        console.log('nope')
        return false;
      });


    }

    if (/guestbook/.test(location)) {
      Brotherus.instances.guestbook = new Brotherus.Guestbook();
    }

  });

});