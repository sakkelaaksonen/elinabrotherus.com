
Brotherus.Guestbook = function(mode) {
//	this.cookieVals = { n:'brotherus_guestbook',v:'set', s:'/', d:1000 };
  this.edit = mode;
	this.feedUrl = '/guestbook/entries.xml';
	this.feed;
	this.$container = $('#guestbookColumn');
	var guestbook = this;
    
	//public
	this.messageHtml = function(entryCount, entryName, entryMessage, pubDate) {
		return	'<div id="entry_'+ entryCount + '" class="guestbook-entry">'
				+(guestbook.edit == 2 ? '<a class="delete" href="/guestbook/delete/" id="delete_entry_'+entryCount+'">delete this entry</a>' : '' )
				+'<h4 class="entryName">'+entryName+'</h4>'
				+'<p class="entryMEssage">'+entryMessage+'</p>'
				+'<p class="date">'+pubDate+'</p></div>';
	}

	//private
	function loadFeed() {
		var column = 	guestbook.$container;
		var items = [];


		//todo:this must be htpasswd or session secured!!! this is just a demo


		//clean up old entries
		$('.guestbook-entry').remove();
		
		$.ajax({
			dataType:'xml',
			type:'get',
			cache:0,
			url:guestbook.feedUrl,
			data:{'do':'get'},
			error:function(data) {
				alert('error');
			try {
				console.log(data)
			}
			catch(e) {
				alert('cant get guestbook entries')
				}
				},
			success:function(xmlData) {			


				$('entry',xmlData).each(function(i) {
                console.log($(this).attr('active') !== '0')
                 if( $(this).attr('active') !== 0) {
					var entryName = $(this).find('name').text();
					var entryMessage = $(this).find('message').text();
					var pubDate =  $(this).find('date').text();
					items.push(guestbook.messageHtml(i, entryName, entryMessage, pubDate));
                }
				});
			
				column.append(items.reverse().join(''));				
				
				if(guestbook.edit)
    				$('a.delete').click(guestbook.deleteEntry);			
			}
		});
			
	}

		//public
//	this.saveFeed = function() {
//		//no double booking
////		if($.cookie(guestbook.cookieVals.n) != null )	return false;
//	   

//		var entry = 	{
//			'do':'save',
//			entryName:$('input#entryName').val(),
//			entryMessage: ( 
//				$('textarea#entryMessage').val().length > 1000 ? 
//					$('textarea#entryMessage').val().substr(0,995)+'[...]' 
//					: 
//					$('textarea#entryMessage').val()  
//			)
//		}
////		$('#add').attr('disabled','disabled');
//		
////		$('form.gb').slideUp('normal',function() {
//		
//		    
//			
////			$.ajax({
////				url:guestbook.feedUrl,
////				data:entry,
////				type:'post',
////				dataType:'text',
////				cache:0,
////				success:function(data) {
////                    guestbook.$container.prepend('<h3 class="hidden">Thank you for your message.</h3>').fadeIn();
////					loadFeed();	
////				
////					//set spam control cookie
//////				 	$.cookie (
//////				 				guestbook.cookieVals.n, 
//////				 				guestbook.cookieVals.v, 
//////				 				{ path: guestbook.cookieVals.s, expires: guestbook.cookieVals.d }
//////				 	);
////				}
////			});	
////		});
//		

//			return false;
//	}

	//private
	var addForm = function () {
//		if( $.cookie(guestbook.cookieVals.n) != null) return false;
		
		var form = '<form method="post" action="/guestbook/save" class="gb clearfix"><h2>Guestbook</h2><p>Leave a message</p> \
			<fieldset> \
				<label for="entryName" class="gblabel">Name</label> \
				<input class="gbfield" type="text" id="entryName" name="entryName" maxlength="40" tabindex="1"/> \
				<a href="#helps" id="helpGuestbook" class="help">? \
					<span>: No html tags or other code. Just text. Maximum 1000 characters</span> \
				</a>\
				<label for="entryMessage" class="gblabel">Message</label> \
				<textarea  maxlength="1000" class="gbfield" id="entryMessage" name="entryMessage" tabindex="2"></textarea> \
			</fieldset> \
			<div class="textRight"> \
			<input type="submit" value="add to guestbook" id="add" tabindex="3"/> \
			</div> \
		</form>';

		$('#guestbookColumn').append(form);
		
		
		
	}
	
	this.deleteEntry = function() {
	//this = a.delete 
		entryBtn = $(this);
		$.post(
			'/guestbook/delete',
			{entry:this.id.split('_').pop()},
			function(data) {
  			if(data == 'entry saved') {
				var $p = entryBtn.parent();
                    $p.html('entry removed');
                    var removeMe = function(){
                        $p.fadeOut(1000,function(){
                            $(this).remove();
                        })
                    }
                    setTimeout(removeMe,1000);

					
				} 
				else {alert('error:could not remove entry');}
		
			}
		);		
		return false;
	}
	
	
	this.init = function(edit) {
		//.blur(function(){$(this).removeClass('focus')});
	
		addForm();
		loadFeed();
		$('.gbfield').focus(function(){	$(this).addClass('focus').select()}).blur(function() {$(this).removeClass('focus')});
		$('input#entryName').focus();
        
        guestbook.$container.find('form').ajaxForm({
            beforeSubmit:function(data,$form){
                if(data[0].value === '' || data[1].value === '') {
                   return false;
                }
                
                if(data[1].value.length > 999) {
                  if (!confirm('Your message is too long and will be shortened to 1000 characters. Click OK to save anyway, cancel to rewrite message')) {
                    
                    $('#entryMessage').addClass('error');
                    return false;
                  }
                    data[1].value = data[1].value.substr(0,995)+'[...]';

                }
                
                $form.slideUp('slow');
            },
            data:{'do':'save'},
            success:function(data){
                guestbook.$container.prepend('<h3 id="thx" class="hidden">Thank you for your message.</h3>').fadeIn('slow');
//                $.scrollTo('#thx',200,{offset:{top:-30}});
                loadFeed();
//                setTimeout(loadFeed,2000);
                
            }
        
        
        });
	}

	this.init();
}



