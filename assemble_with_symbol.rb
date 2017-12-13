lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "pry-byebug"
require "hack_asm"

filename = './MaxL.asm'
# filename = './MaxL.asm'
output = './Prog.hack'
parser = HackASM::Parser.new(filename)
bincodes = []

while parser.hasMoreCommand?
  command = parser.advance
  p command
  p parser.commandType
  # binding.pry
  if parser.commandType == 'C_COMMAND'
    bin = HackASM::Code.to_binary(parser)
    p bin
    bincodes.push(bin)
  elsif parser.commandType == 'A_COMMAND'
    bin = parser.symbol_to_bin
    p bin
    bincodes.push(bin)
  end
end

begin
  File.open(output, 'w') do |file|
    # binding.pry
    while code = bincodes.shift
      file.puts(code)
    end
  end
rescue => e
  puts e.message
end
