module HackASM
  class Parser

    attr_reader :file, :command

    def initialize(filename)
      return if filename.nil?
      @command = nil
      @file = []
    begin
      File.open(filename) do |file|
        file.read.split(/\n|\r|\r\n/).each do |line|
          next if line.empty? # 空行はスキップ
          next if line.match(/^\s*\/\//) # コメント行はスキップ
          line = remove_spaces(line)
          @file.push(line)
        end
      end
    rescue => e
      puts e.message
    end
    end

    def hasMoreCommand?
      !@file.empty?
    end

    def advance
      return nil unless hasMoreCommand?
      @command = @file.shift
      @command
    end

    def commandType
      types = ['A_COMMAND', 'C_COMMAND', 'L_COMMAND']
      if @command.match(/@(.+)/)
        types[0]
      elsif @command.match(/=|;/)
        types[1]
      elsif @command.match(/^\((.+)\)$/)
        types[2]
      else
        raise "Parse error: @command did not match any types of commands."
      end
    end

    def symbol
      return nil if commandType == 'C_COMMAND'
      if commandType == 'A_COMMAND'
        match = @command.match(/@(.+)/)
        match[1]
      elsif commandType == 'L_COMMAND'
        match = @command.match(/^\((.+)\)$/)
        match[1]
      end
    end

    def dest
      match = parse(@command)
      return nil if match.nil? || match[1].nil?
      match[1]
    end

    def comp
      match = parse(@command)
      return nil if match.nil? || match[2].nil?
      match[2]
    end

    def jump
      match = parse(@command)
      return nil if match.nil? || match[3].nil?
      match[3]
    end

    # output binary code of each command types
    def symbol_to_bin
      if symbol.to_i.is_a? Integer
        symbol.to_i.to_s(2).rjust(16, '0')
      else

      end
    end

    private

    def parse(command)
      return nil if commandType != 'C_COMMAND'
      command.match(/(\w+)?=?(\w+[\+\-\&\|]?\w*);?(\w+)?/)
    end

    def remove_spaces(line)
      match = line.match(/^\s*(\S+)\s*(\/\/.*)?$/)
      return match[1] if match
      line
    end
  end
end
