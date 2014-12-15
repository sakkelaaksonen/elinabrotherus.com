require 'json'
gals = JSON.parse(File.read( 'allgalleries.json'))
gals['galleries'].map do |g| 
  g['pics'].each do |pic|
    # puts pic['id']
    pic['id'] = pic['id'].to_s
    if pic['id'].length < 2
      pic['id'] = "0#{pic['id']}"
    end
    # puts pic['id']
  end
end


File.open("allgalleries.json", "w") { |file|  file << gals.to_json}



