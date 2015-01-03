require 'fileutils'
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

def number_filename(filename,path)
  return "#{path}#{File.basename(filename)[0..1]}.jpg"
end

path = ARGV.empty? ? '.' : ARGV[0]

 files = Dir.glob("#{path}*.jpg")
 
# #make a copy that only has index number in name
 files.each do |f|  
   FileUtils.cp(f ,number_filename(f,path)) 
 end
 

#make CSV data into JSON data
# file = Dir.glob("#{path}files.csv")
 


# data = []
# pics = CSV.read("#{path}file.csv",{col_sep:';'})
# idpath = File.dirname(file)
# data.push( gallery_obj({
#       id: idpath,
#       folder: idpath,
#       name: :name,
#       pics: pics
# }))
# File.open("#{path}file.json", 'w') { |file| file.write(data.to_json) }


