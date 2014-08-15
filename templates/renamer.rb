Dir.glob('*.html') do |f|
command = "mv #{f} #{f.gsub('html','mustache')}"
puts command
system command

end