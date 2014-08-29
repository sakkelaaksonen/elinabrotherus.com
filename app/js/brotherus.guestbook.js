Brotherus.Guestbook = function(mode) {
  //  this.cookieVals = { n:'brotherus_guestbook',v:'set', s:'/', d:1000 };
  this.edit = mode;
  this.feedUrl = '/guestbook/entries.xml';
  this.feed;
  this.$container = $('#guestbookColumn');
  var guestbook = this;

  //public
  this.messageHtml = function(entryCount, entryName, entryMessage, pubDate) {
    return '<div id="entry_' + entryCount + '" class="guestbook-entry">'
      // +(guestbook.edit == 2 ? '<a class="delete" href="/guestbook/delete/" id="delete_entry_'+entryCount+'">delete this entry</a>' : '' )
      + '<h4 class="entryName">' + entryName + '</h4>' + '<p class="entryMEssage">' + entryMessage + '</p>' + '<p class="date">' + pubDate + '</p></div>';
  }

  //private
  function loadFeed() {
    var column = guestbook.$container;
    var items = [];


    //clean up old entries
    $('.guestbook-entry').remove();

    $.ajax({
      dataType: 'xml',
      type: 'get',
      cache: 0,
      url: guestbook.feedUrl,
      data: {
        'do': 'get'
      },
      error: function(data) {
        alert('error');
        try {
          console.log(data)
        } catch (e) {
          alert('cant get guestbook entries')
        }
      },
      success: function(xmlData) {


        $('entry', xmlData).each(function(i) {
          console.log($(this).attr('active') !== '0')
          if ($(this).attr('active') !== 0) {
            var entryName = $(this).find('name').text();
            var entryMessage = $(this).find('message').text();
            var pubDate = $(this).find('date').text();
            items.push(guestbook.messageHtml(i, entryName, entryMessage, pubDate));
          }
        });

        column.append(items.reverse().join(''));

        if (guestbook.edit)
          $('a.delete').click(guestbook.deleteEntry);
      }
    });

  }


  this.init = function(edit) {

    loadFeed();
    $('.gbfield').focus(function() {
      $(this).addClass('focus').select()
    }).blur(function() {
      $(this).removeClass('focus')
    });
    $('input#entryName').focus();

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