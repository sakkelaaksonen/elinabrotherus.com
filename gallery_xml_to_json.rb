require 'nokogiri'
require 'json'
galleryxml = Nokogiri::XML::parse(File.read('gallerytemp.xml'))
puts galleryxml

galleryhash =  galleryxml.xpath('//gallery').map do |node|
  # {
  #   # childen: node.xpath('folder').text
  node.xpath('pic').each_with_index.map { |pic,i|
  {
    id: "#{(i<10 ? '0':'')}#{i+1}",
    #src: "#{node.xpath('folder').text}/#{pic.xpath('lores').text}.jpg",
    name: pic.xpath('title').text,
    dimensions: pic.xpath('dimensions').text,
    year: pic.xpath('year').text,
    edition: ( pic.xpath('editions').text.empty?  ? '6' : pic.xpath('editions').text )
  }}.flatten
  # }
end

# # puts galleryhash.to_json
# # newjson = JSON.parse(File.read('newfiles.json'))
# # newjson['galleries'].concat(galleryhash)

# g = JSON.parse(File.read('allgalleries.json'))
# gh = g['galleries'].map do |gal|
#     gal['pics'].each { |pic| pic['edition'] = "6" }
# end

File.open('gallerytemp.json','w') {|f| f.write(galleryhash.to_json)}
