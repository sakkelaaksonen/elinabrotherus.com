require 'nokogiri'
require 'json'

galleryxml = Nokogiri::XML::parse(File.read('xml/gallery.xml'))
galleryhash =  galleryxml.xpath('//gallery').map do |node|
    {
        # childen: node.xpath('folder').text
        id: node.attr('id'),
        url: node.xpath('folder').text,
        name: node.xpath('name').text,
        pics: node.xpath('pic').each_with_index.map {|pic,i| {
                id: i,
                src: "#{node.xpath('folder').text}/#{pic.xpath('lores').text}.jpg",
                title: pic.xpath('title').text
        }}
    }
end
galleryhash.to_json
newjson = JSON.parse(File.read('newfiles.json'))
newjson['galleries'].concat(galleryhash)
File.open('allgalleries.json','w') {|f| f.write(newjson.to_json)}
