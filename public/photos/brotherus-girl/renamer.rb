require 'fileutils'
files = Dir.glob('*.jpg') 
files.each do |f|
  number = f.match(/(\d\d).jpg$/)
  # p number[1]
  FileUtils.cp(f ,"#{number[1]}.jpg")
end