require "option_parser"

module Lff
  VERSION = "0.1.0"
  computer_mode = false
  file_number = 10
  directory_root = ""

  OptionParser.parse do |parser|
    parser.banner = "Usage: lff [directory] [arguments]"
    parser.on("-c", "--computer", "When used this option the printed file size will be in number and without color.") { computer_mode = true }
    parser.on("-n NUMBER", "--number=NUMBER", "The maximum number of files to print out, default is 10.") { |number| file_number = number }
    parser.on("-v", "--version", "Show current version.") do
      puts "lff version #{VERSION}"
      exit
    end
    parser.on("-h", "--help", "Show help screen.") do
      puts parser
      exit
    end

    parser.invalid_option do |flag|
      STDERR.puts "\e[31mERROR:\e[0m #{flag} is not a valid option."
      STDERR.puts parser
      exit(1)
    end

    parser.missing_option do |flag|
      STDERR.puts "\e[31mERROR:\e[0m #{flag} is missing option."
      STDERR.puts parser
      exit(1)
    end
  end

  directory_root = ARGV.empty? ? "." : ARGV[0]
  begin
    file_number = UInt8.new(file_number)
  rescue exception
    STDERR.puts "\e[31mERROR:\e[0m Can not parser number or out of range."
    exit(1)
  end

  puts "Computer mode: #{computer_mode}"
  puts "File number: #{file_number}"
  puts "Directory root: #{directory_root}"
end
