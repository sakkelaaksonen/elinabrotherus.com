require 'nokogiri'
require 'json'
# galleryxml = Nokogiri::XML::parse(File.read('gallerytemp.xml'))
# puts galleryxml

# galleryhash =  galleryxml.xpath('//gallery').map do |node|
#   {
#     # childen: node.xpath('folder').text
    
#     pics: node.xpath('pic').each_with_index.map { |pic,i|

#       {
#         id: "#{(i<10 ? '0':'')}#{i+1}",
#         #src: "#{node.xpath('folder').text}/#{pic.xpath('lores').text}.jpg",
#         name: pic.xpath('title').text,
#         dimensions: pic.xpath('dimensions').text,
#         year: pic.xpath('year').text,
#         edition: pic.xpath('editions').text
#     }}
#   }
# end



# # puts galleryhash.to_json
# # newjson = JSON.parse(File.read('newfiles.json'))
# # newjson['galleries'].concat(galleryhash)

g = JSON.parse(File.read('allgalleries.json'))
g['galleries'].each do |gal|
    gal['pics'].each { |pic| pic['edition'] = "6" }
end

File.open('allgalleries2.json','w') {|f| f.write(g.to_json)}
