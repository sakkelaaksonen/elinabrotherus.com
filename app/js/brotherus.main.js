//before onload


 //onload -> 
 //if(Brotherus.init.fancyAlert)
 	//alert('you fancy pancy');

 /****************
 //onload
 ****************/
Brotherus.inits = function(){
//navi effect
//	Brotherus.running.mainNavi = new Brotherus.effects.MainNavi();
	
//frontpage gallery
	if(Brotherus.init.fpPics)
		Brotherus.running.frontPics = new Brotherus.gallery.InitGallery($('#browser'));
//gallery
	if(Brotherus.init.gallery)
		Brotherus.running.gallery = new Brotherus.gallery.InitGallery($('#browser'));
//thumbs
	if(Brotherus.init.thumbs)
		Brotherus.running.thumbs  = new Brotherus.gallery.InitThumbs($('.thumbsContainer'));
//about  this series in shadowbox
	if(Brotherus.init.about)
		Brotherus.running.about = new Brotherus.initAbout();
		
		
	if(Brotherus.init.guestbook)
		Brotherus.running.Guestbook = new Brotherus.Guestbook(Brotherus.init.guestbook);
	
	//section initialization
	if(Brotherus.init.sections)
		Brotherus.running.Sections = new Brotherus.Sections();
	
	
//	Brotherus.running.news = new Brotherus.newsEffecs();
//	if($('.newsContainer').length>0) {
//		var newTag = '<span class="newTag">New</span>';
//		$('.newsContainer').addClass('dynamic');
//	
//	
//		$('.newsItem h3').click(function() {
//				$(this).siblings('p[@class!="ingress"]').slideToggle('normal');						
//			});
//	
//		$('.newsItem:first').addClass('first').find('h3 span.date').after(newTag);
//	}
//	


};

