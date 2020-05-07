require "option_parser"
require "./util/*"

module Lff
  VERSION     = "0.1.1"
  DESCRIPTION = "Simple and straightforward large files finder utility for *nix, optimize for human."

  directory_root = ""
  file_limit = 10
  computer_mode = false

  OptionParser.parse do |parser|
    parser.banner = "#{DESCRIPTION}\nUsage: lff [directory] [arguments <optional>]"
    parser.on("-c", "--computer", "When used this option the printed file size will be in number and without color.") { computer_mode = true }
    parser.on("-n NUMBER", "--number=NUMBER", "The maximum number of files to print out, default is 10.") { |number| file_limit = number }
    parser.on("-v", "--version", "Show current version.") do
      puts "lff version #{VERSION}"
      exit
    end
    parser.on("-h", "--help", "Show help.") do
      puts parser
      exit
    end

    parser.invalid_option do |flag|
      STDERR.puts "\e[31mError:\e[0m #{flag} is not a valid option."
      STDERR.puts parser
      exit(1)
    end

    parser.missing_option do |flag|
      STDERR.puts "\e[31mError:\e[0m #{flag} is missing option."
      STDERR.puts parser
      exit(1)
    end
  end

  begin
    directory_root = ARGV.empty? ? "." : ARGV[0]
    file_limit = UInt8.new(file_limit)
    scanned_result = scan(directory_root.to_s)
    sort_result = sort(scanned_result, file_limit.to_i)
    print_result(sort_result.as(Array(Tuple(String, Int64))), computer_mode)
  rescue exception
    STDERR.puts "\e[31mError:\e[0m #{exception.message}"
    exit(1)
  end
end
