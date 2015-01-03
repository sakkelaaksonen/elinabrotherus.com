Brotherus.Guestbook = function(mode) {
  //  this.cookieVals = { n:'brotherus_guestbook',v:'set', s:'/', d:1000 };
  this.edit = mode;
  // this.feedUrl = '/guestbook/entries.xml';
  this.feedUrl = '/guestbook/entries.json';
  this.feed;
  this.$container = $('#js-entries');
  var guestbook = this;

  //public
  this.messageHtml = function(entry, index) {
    console.log(arguments)
    return [
      '<div id="entry_', index, '" class="guestbook-entry col-xs-12 col-sm-12">',
      '<h4 class="entryName">', entry.name, '</h4>',
      '<p class="entryMEssage">', entry.message, '</p>',
      '<p class="date">', entry.date, '</p></div>'
    ].join('');
  }

  //private
  function loadFeed() {
    var column = guestbook.$container;
    var items = [];

    //clean up old entries
    $('.guestbook-entry').remove();

    return $.ajax({
      dataType: 'json',
      type: 'get',
      cache: 0,
      url: guestbook.feedUrl,
      error: function(data) {
        alert('error');
        try {
          console.log(data)
        } catch (e) {
          alert('cant get guestbook entries')
        }
      },
      success: function(jsondata) {
        $(jsondata.guestbook.entry).each(function(index, entry) {
          items.push(guestbook.messageHtml(entry, index));
        });

        column.append(items.reverse().join(''));

        if (guestbook.edit)
          $('a.delete').click(guestbook.deleteEntry);
      }
    });

  }


  this.init = function(edit) {

    loadFeed().done(function() {



    });

    // $('.js-').focus(function() {
    //   $(this).addClass('focus').select()
    // }).blur(function() {
    //   $(this).removeClass('focus')
    // });
    // $('input#entryName').focus();

    guestbook.$container.find('form').ajaxForm({
      beforeSubmit: function(data, $form) {
        if (data[0].value === '' || data[1].value === '') {
          return false;
        }

        if (data[1].value.length > 999) {
          if (!confirm('Your message is too long and will be shortened to 1000 characters. Click OK to save anyway, cancel to rewrite message')) {
            $('#entryMessage').addClass('error');
            return false;
          }
          data[1].value = data[1].value.substr(0, 995) + '[...]';
        }
        $form.slideUp('slow');
      },
      data: {
        'do': 'save'
      },
      success: function(data) {
        guestbook.$container.prepend('<h3 id="thx" class="hidden">Thank you for your message.</h3>').fadeIn('slow');
        loadFeed();
      }


    });
  }
  this.init();
}