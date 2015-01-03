# encoding: UTF-8
require 'nokogiri'
require 'csv'
require 'json'

def gallery_obj(params)
	#dont be destructive
	pics = params[:pics]
	fol = params[:folder]
	gallery_name = params[:name]
	
	gallery = {
		id: params[:id],
		folder: fol,
		name: gallery_name
	}

	gallery[:pics] = pics.map do |img|
		{
			id: img[0],
	    src: "#{fol}/#{img[0]}.jpg",
	    name: img[1],
	    dimensions: img[2],
	    year: img[3],
	    edition: img[4]
		}
	end
	return gallery

end

def csv_to_hash()
	root = {galleries:[]}
	files = Dir.glob('*/files.csv') 
	
	files.each do |f|
		pics = CSV.read(f,{col_sep:';'})
		pics.shift
		idpath = File.dirname(f)
		root[:galleries].push( gallery_obj({
					id: idpath,
					folder: idpath,
					name: :name,
					pics: pics
					}))
	end
	
	return root

end

def combine_galleries
	json_file = 'newfiles.json'
	hash = csv_to_hash()
		['What If','12 Ans Apres','Annonciation'].each_with_index do |name, i|
		hash[:galleries][i][:name] = name
	end

	File.open(json_file,'w') {|f| f << hash.to_json}



	old_file = Nokogiri::XML(File.open( '/home/sakke/elinabrotherus.com/assets/xml/gallery.xml'))
	galleries = old_file.xpath('//gallery')
	return galleries.map do |node|
  	node.children.map{|n| [n.name,n.text.strip.gsub("\t",'')] if n.elem? }.compact
	end.compact
	#galleries.each do |gal|
		#puts gal.methods
	#end
end

# combine_galleries()