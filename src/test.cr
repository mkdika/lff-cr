path = ARGV.empty? ? "." : ARGV[0]

limit = 0..9
result = entriex(path).to_a.sort_by { |key, value| value }.reverse
result[limit].each do |path, size|
  line = String.build do |io|
    io << "\e[32m" << size.humanize(precision: 1, significant: false).rjust(6, ' ') << "\e[0m " << path
  end
  puts line
end

def entriex(path)
  arr_file = {} of String => UInt64
  dirs = Dir.entries path
  return arr_file if dirs.empty?
  arr_dir = [] of String
  dirs.each do |e|
    if File.file?("#{path}/#{e}")
      size = File.size "#{path}/#{e}"
      arr_file["#{path}/#{e}"] = size if size > 0
    elsif e != "." && e != ".."
      arr_dir << "#{path}/#{e}"
    end
  end
  unless arr_dir.empty?
    channel = Channel(Hash(String, UInt64)).new
    arr_dir.each do |d|
      spawn do
        arr = entriex d
        channel.send arr
      end
      callback = channel.receive
      arr_file.merge!(callback)
    end
  end
  arr_file
end
