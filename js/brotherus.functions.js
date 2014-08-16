
/**
 * @author sakke laaksonen

 notation:
 	function -> someFunction()
 	object -> SomeObject
 	jQuery object -> $somejQVar
 	basic javascript var -> someVar
  */
 //contains boolean values that define which features are used in a page instance
 //ex. Brotherus.init.fancyAlert = 1
 

/**********************
//functions

***********************/
//Brotherus.newsEffects = function () {
//	fthis = this;
//	this.init = function() {
//	alert('news');
////		//news
////	if($('newsContainer').length==0)
////		return false;
////	
////	$('.newsContainer').addClass('dynamic');
////
////	$('.ingress:not(":first")').click(function() {
////			$(this).siblings('.more').slideToggle('normal');						
////		});
////		
////		return true;
//	}
//	
//	this.init();	
//}


//Some hover effecs 


//Brotherus.effects.MainNavi = function () {
//	$('.naviSection li a').hover(
//		function () {
//			$(this).addClass('hover').animate({'paddinRight','3px'},500) ;
//		},
//		function () {
//			$(this).removeClass('hover');	
//		}
//		
//	);
//		
//}



//gallery application
Brotherus.gallery.InitGallery = function ($container,args) {

	var	gThis = this;
	this.args = {};
	if (args !== undefined) 
		this.args = args;
	
	
	this.$b = $container;
	if(this.$b.length ==0) {
//		console.log('invalid gallery container');
		return false;
	}
	
	this.$imageNow = this.$b.find('div.pic:first');

	this.init = function () {
		
		gThis.$b.find('div.pic').wrapAll('<div class="picContainerWrapper"><div id="picContainer"></div></div>');
		gThis.$b.find('div.pic img').wrap('<table><tr><td style="width:370px;height:400px"></td></tr></table>');
		gThis.$b.find('.browserBtn').click(gThis.togglePic);
//show first image



	//	gThis.$imageNow.fadeIn('slow');
	$('div.pic:first').css('display','block'); //Safari fix
//show series data
		gThis.$b.find('#browserControls .seriesName').text($('h2 .seriesName').text());
		gThis.$b.find('#browserControls .seriesDate').text($('h2 .seriesDate').text());
//show image data
		gThis.updatePicData();

	} //end of gallery.init
	
//	
	this.openPic = function(idNum) {
		gThis.$imageNow = $(idNum);
		gThis.$b.find('div.pic:visible').hide();
		gThis.$imageNow.fadeIn('slow');	
		gThis.updatePicData();
	} //end of gallery.openPic
	
	this.updatePicData = function () {
		//pic name
		gThis.$b.find('#browserControls .picName').text(gThis.$imageNow.find('h3').text())
		//gThis.$b.find('#browserControls .Name').text(gThis.$imageNow.find('h3').text())
gThis.$imageNow.find('p').text() ;
		
		
	} //end of gallery.updatePicData
	
	
	this.togglePic = function () {
	
		if($(this).hasClass('btnLeft')) {
			gThis.$imageNow.prev().length > 0?
				gThis.$imageNow = gThis.$imageNow.prev() :				
				gThis.$imageNow = gThis.$b.find('div.pic:last');
		
		}	
		
		else if($(this).hasClass('btnRight')) {
			gThis.$imageNow.next().length > 0 ?
				gThis.$imageNow = gThis.$imageNow.next() :
				gThis.$imageNow = gThis.$b.find('div.pic:first');
		}

		gThis.$b.find('div.pic:visible').hide();
		gThis.$imageNow.fadeIn('slow');	
		gThis.updatePicData();

		if(Brotherus.running.thumbs) {
			Brotherus.running.thumbs.update();
		}


		return false;	
	
	} //end of gallery.togglePic
	

	this.init();
} //end of gallery


//gallery thumbs
Brotherus.gallery.InitThumbs = function ($container) {
	var thumbs = this;
	this.$cont = $container;
	this.scroller= {topLimit:'', bottomLimit:'', scrollVal:400, handle:'', height:false}
	this.buttons = {};
	
	if(	this.$cont.length == 0) {
//		console.log('invalid thumbs container');
		return false;
	
	}

	this.$cont.addClass('dynamic');

	this.init = function() {
		 var $mask = 	$('.thumbsMask');
		 
		 var visibleCount = 1;
		//create the thumbs from the "real pictures" 
		 $('#picContainer div.pic').each(function() {
		 	var thumbSrc = $(this).find('img').attr('src');
		 	var thumbHref = this.id
			var thumb = '<a href="#'+thumbHref+'" class="thumb"><img src="'+thumbSrc+'"/></a>';
			$mask.append(thumb);
		});
		
		//hide all thumbs after visibleum
		$('a.thumb').wrapAll('<div id="scroller"></div>');
		
		//bind the picture opening function to thumbs
		$('a.thumb').click( function() {
			Brotherus.running.gallery.openPic('#'+this.href.split('#')[1]);
			$('a.thumb').removeClass('active');
			$(this).addClass('active');
			return false;
		});
		
			//get scroller dimensions
		pos = findPos($('.thumbsMask').get(0));
		this.scroller.handle = $('#scroller');
		this.scroller.topLimit = pos.y;
		this.scroller.bottomLimit = this.scroller.topLimit+this.scroller.scrollVal;
		this.scroller.height =  $('#scroller').innerHeight()	;
			
		this.buttons.$up = $('.arrowUp');
		this.buttons.$down = $('.arrowDown');
			//bind scrolling 
		this.buttons.$up.click(this.scrollUp);
		this.buttons.$down.click(this.scrollDown);

		this.update();
	} //end of thumb.init
	
	this.focusScroller = function(params) {
		var sVal;
		var scrollPixels;
		
		//above the mask
			if(params.p.y < thumbs.scroller.topLimit) {
				sVal = thumbs.scroller.topLimit - params.p.y;
				scrollPixels = '+='+ sVal+'px';
				}
		//below the mask
			else if( (params.p.y + params.$a.height() ) > thumbs.scroller.bottomLimit) {
				sVal =  (params.p.y + params.$a.height() ) - thumbs.scroller.bottomLimit ;
				scrollPixels = '-='+ sVal+'px';
				
				}
			//insight,nothing to do
			else {return false;} 
				
		//still animating? do nothing. don't break the scroller
		if( $('#scroller:animated').length > 0 ) return false;
		//scroll if you are scrolling
		thumbs.scroller.handle.animate({'top':scrollPixels},500);
	}
	

	
	
	this.scrollUp = function() {
		if( $('#scroller:animated').length > 0 ) return false;
	
			//maybe queue this event?
		var scrollPixels= '+='+thumbs.scroller.scrollVal+'px';
		var topVal = (thumbs.scroller.handle.css('top').split('px')[0]*1);
		//console.log('scroller xTop:'+topVal);
		if( topVal<0) {
				//console.log(thumbs.scroller.scrollVal + topVal);
				if((thumbs.scroller.scrollVal + topVal) > 0)
				scrollPixels = '+='+ (thumbs.scroller.scrollVal-(thumbs.scroller.scrollVal + topVal))+'px';

			thumbs.scroller.handle.animate({'top':scrollPixels},500);
		} 
		
		//can be used with anchor tags
		return false;
	
	}//end of thumbs.scrollUp
	
		
	this.scrollDown = function() {
		if( $('#scroller:animated').length > 0 ) return false;

		var scrollPixels = '-='+thumbs.scroller.scrollVal+'px';
		var scrollerPos = findPos(thumbs.scroller.handle.get(0));
		var bottomPos = scrollerPos.y + thumbs.scroller.handle.innerHeight();

//	var trigger = (bottomPos - thumbs.scroller.scrollVal) < thumbs.scroller.bottomLimit;

		if((bottomPos - thumbs.scroller.scrollVal) < thumbs.scroller.bottomLimit) 
		{
			diff = 0-((bottomPos - thumbs.scroller.scrollVal) - thumbs.scroller.bottomLimit);
			scrollPixels = '-='+(thumbs.scroller.scrollVal-diff)+'px';
		}
//something fusked in safari height calculations
		thumbs.scroller.handle.animate({'top':scrollPixels},500);
		
		
		return false;
	
	} //end of thumbs.scrollDown
	
	this.update = function() {

		var newId = Brotherus.running.gallery.$imageNow.attr('id')
		$('a.thumb').removeClass('active');
		var $active =	$('a.thumb[href*="#'+newId+'"]');
		$active.addClass('active');	

		var positions = findPos($active.get(0));

		thumbs.focusScroller({'$a':$active,p:positions});

		} //end of thumbs.update
		
	this.init();	
} //end of thumbs

Brotherus.initAbout = function () {
    if($('#aboutOverlay').length === 0)
        $('body').append('<div id="aboutOverlay" class="overlay"><h2 class="title"></h2><div class="content"></div></div>');



    $('a.about').overlay({
        target:'#aboutOverlay',
        mask:{color:'#000',opacity:0.8,loadSpeed:'fast'},
        onBeforeLoad:function() {
            var $l = this.getOverlay();
            $('.content',$l).html('<div class="cBox hidden">' + $('#aboutContent').html() + '</div>');
            $('.title',$l).text($('#aboutContent').find('.sBTitle:first').text());
            
            
        },
        onLoad:function(){
            this.getOverlay().find('.cBox').fadeIn();    
        }
    })
}

//shadowbox initiating function
Brotherus.InitShadowbox = function(type) {
	

	var sbox = this; //reference for inner functions
	this.boxes = {
		about: 
			{
				animate: false,
		        player:     'html',
		        title:      '',
		        content:    'please give me some content',
				height:410,
				width:600,
				handleResize:'resize',
				overlayOpacity:0.5
			}	
		
	}
	
    Shadowbox.init({skipSetup: true});
    
    switch(type) {

	    case 'about':
	    
	  if ( $('#aboutContent').length == 0) {
	  	return false;	
	  }
	  
	  $('a.shadowbox.about').click(function() { 
//		  	contentId = '#'+this.href.split('#')[1];
			var options = sbox.boxes[type];
			options.title = $('#aboutContent').find('.sBTitle:first').text();
			$('#aboutContent .sBTitle').remove();	
			options.content = '<div class="cBox">' + $('#aboutContent').html() + '</div>';
			
	 		 Shadowbox.open(options);
	
		});
	 }
    
	return type;
}


function findPos(obj) {
//from http://www.quirksmode.org/js/findpos.html
//credits and respect
	var curleft = curtop = 0;
	if (obj.offsetParent) {
		curleft = obj.offsetLeft
		curtop = obj.offsetTop
		while (obj = obj.offsetParent) {
			curleft += obj.offsetLeft
			curtop += obj.offsetTop
		}
	}
	return {x:curleft,y:curtop};
}


Brotherus.Sections = function () {
//	var pattern = /^section\_[\d{1,3}$] / ;
	var sections = this;

	this.toggleSections = function () {
		$('a.sectionLink').removeClass('active');
		$(this).addClass('active');
		$('div.section').hide();
		$('div#'+this.href.split('#')[1]).fadeIn('normal');
	}
	
	this.init = function() {
		var hash = location.hash.split('#')[1];
		
		//not working in Safari 3 :(
		
		$('a.sectionLink').click(sections.toggleSections);
		
		if(hash === undefined) { $('a.sectionLink:first').click();}

		else {$('a[href*='+hash+']').click()	}


	}
	
	this.init();

}
