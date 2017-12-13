lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "pry-byebug"
require "hack_asm_with_symbol"

# filename = './MaxL.asm'
# filename = './Max.asm'
filename = './Add.asm'
# filename = './Pong.asm'

output = './Prog.hack'

parser = HackASM::Parser.new(filename)
symbol_table = HackASM::SymbolTable.new

# This while loop making symbol table
address = 16 # Label address starts from 0x10
line = 0 # 処理中の行番号(from 0)
while parser.hasMoreCommand?
  line += 1
  command = parser.advance
  next if 'C_COMMAND' == parser.commandType
  symbol = parser.symbol

  p symbol
  if 'A_COMMAND' == parser.commandType
    next if symbol_table.contains?(symbol)
    if match = symbol.match(/^(\d+)/)
      symbol_table.addEntry( symbol, match[1].to_i )
    else
      symbol_table.addEntry( symbol, address )
      address += 1
    end
  end

  if 'L_COMMAND' == parser.commandType
    symbol_table.addEntry( symbol, line - 1 )
    line -= 1
  end
end

bincodes = []
parser = HackASM::Parser.new(filename)

while parser.hasMoreCommand?
  command = parser.advance
  p command
  p parser.commandType
  if parser.commandType == 'C_COMMAND'
    bin = HackASM::Code.to_binary(parser)
    p bin
    bincodes.push(bin)
  elsif parser.commandType == 'A_COMMAND'
    bin = symbol_table.getAddress(parser.symbol)
    p bin
    bincodes.push(bin)
  end
end

begin
  File.open(output, 'w') do |file|
    while code = bincodes.shift
      file.puts(code)
    end
  end
rescue => e
  puts e.message
end
