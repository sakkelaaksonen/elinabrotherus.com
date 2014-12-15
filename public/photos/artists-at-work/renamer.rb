require 'fileutils'
files = Dir.glob('*.jpg') 
files.each do |f|
  FileUtils.cp(f ,"#{f[0..1]}.jpg")
end