

class FilesUtils
  #include DirtyHack
  @windows = true if /cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM
  SEPARATOR =  @windows ? "\\" : "/"
  WINDOWS_EXTENSION_MATCHER = %r/\A.*\\.*\.[a-zA-z]{1,}\z/  #finish with group
  LINUX_EXTENSION_MATCHER = %r|\A.*/.*\.[a-zA-z]{1,}\z|
  EXTENSION_MATCHER = @windows ? WINDOWS_EXTENSION_MATCHER : LINUX_EXTENSION_MATCHER
  attr_reader :path

  def initialize(path:)
    raise ArgumentError, 'The path can not be empty' if path.empty?
    @path = Dir.new(path)
  end

  def path=(path)
    raise ArgumentError, 'The path can not be empty' if path.empty?
    @path.chdir(path)
  end


  #, content_type => :all
  def self.list_content(path, list_recursive: false,
                        include_full_path: false, show_files_only: false)
    hidden_directory_pattern = %r/\A(\.|\.\.)\z/
    list = []
    dir_path = Dir.new(path)
    dir_path.each do |e|
      if self.file?(e)
        list.push(e)
      else
        next if e =~ hidden_directory_pattern
        list.push(e) unless show_files_only
        if list_recursive
          rec_path = path + "#{SEPARATOR}#{e}"
          rec_list = self.list_content(rec_path, list_recursive: list_recursive,
                                      include_full_path: include_full_path,
                                      show_files_only: show_files_only)
          rec_list.map! { |n| "#{SEPARATOR}#{e}" + n} unless show_files_only
          list.concat(rec_list)
        end
      end
    end
    list.map! { |p| "#{path}#{SEPARATOR}" + p} if include_full_path
    return list
  end


  def list_content(list_recursive: false, include_full_path: false, show_files_only: false)
    self.list_content(@path, list_recursive: list_recursive,
                            include_full_path: include_full_path,
                            show_files_only: show_files_only)
  end

  def self.file?(name)
    file_pattern = %r/\A.*\.[a-zA-z]{1,}\z/i
    name =~ file_pattern
  end

end
#
# module DirtyHack
#   refine String do
#     def dir?(file)
#       fil
#     end
#
#     def type(file)
#     end
#   end
# end
