def scan(directory_root : String)
  raise Exception.new("argument is not a directory.") unless File.directory? directory_root

  files = {} of String => Int64
  entries = Dir.entries directory_root
  return files if entries.empty?

  next_dirs = [] of String
  entries.each do |e|
    next if File.symlink?("#{directory_root}/#{e}")
    begin
      if File.file?("#{directory_root}/#{e}")
        size = File.size "#{directory_root}/#{e}"
        files["#{directory_root}/#{e}"] = size.to_i64 if size > 0
      elsif e != "." && e != ".."
        next_dirs << "#{directory_root}/#{e}"
      end
    rescue ex
      raise Exception.new(ex.message)
    end
  end

  unless next_dirs.empty?
    channel = Channel(Hash(String, Int64)).new
    next_dirs.each do |d|
      spawn do
        result = scan(d)
        channel.send result
      end
      callback_result = channel.receive
      files.merge!(callback_result)
    end
  end
  files
end

def sort(map : Hash(String, Int64), file_limit : Int32)
  return [] of Array({String, Int64}) if map.empty? || file_limit < 1
  begin
    arr = map.to_a.sort_by { |key, value| value }.reverse
    arr[0..(file_limit - 1)]
  rescue ex
    raise Exception.new(ex.message)
  end
end

def print_result(arr : Array(Tuple(String, Int64)), computer_mode : Bool)
  result = [] of String
  return result if arr.empty?
  rsize = arr[0][1].to_s.size
  arr.each do |path, size|
    begin
      line = String.build do |io|
        if computer_mode
          io << size.to_s.rjust(rsize, ' ') << " " << path
        else
          io << "\e[32m" << size.humanize(precision: 1, significant: false).rjust(6, ' ') << "\e[0m " << path
        end
      end
      puts line
      result << line.to_s
    rescue ex
      raise Exception.new(ex.message)
    end
  end
  result
end
