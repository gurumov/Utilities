@separator = /cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM ? "\\" : "/"
puts @separator
