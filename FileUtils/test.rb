@separator = /cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM ? "\\" : "/"
puts @separator


fl.each do |f|
old_file_name = File.basename(f, ".*")
ext_name = File.extname(f)
n_file_name = old_file_name + "_orig"
dir_name = File.dirname(f)
old_name = dir_name+
