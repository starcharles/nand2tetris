module HackASM
  class SymbolTable

    SYMBOLS = {
      # Ri: 'i',
      SP: '0000000000000000',
      LCL: '0000000000000001',
      ARG: '0000000000000010',
      THIS: '0000000000000011',
      THAT: '0000000000000100',
      SCREEN: '0100000000000000',
      KBD: '0110000000000000',
    }

    attr_reader :symbols

    def initialize
      @symbols = SYMBOLS

      # add R0 〜 R15 to SYMBOLS
      for num in 0..15 do
        SYMBOLS["R#{num}".to_sym] = num.to_s(2).rjust(16, '0')
      end
    end

    def addEntry(symbol, address)
      padded_address = address.to_s(2).rjust(16,'0')
      @symbols.store(symbol, padded_address)
    end

    def contains?(symbol)
      @symbols.has_key?(symbol) || @symbols.has_key?(symbol.to_sym)
    end

    def getAddress(symbol)
      @symbols[symbol] || @symbols[symbol.to_sym]
    end
  end
end
