module HackASM
  class Parser

    attr_reader :file, :command

    def initialize(filename) return if filename.nil?
      @command = nil
      @file    = []
    begin
      File.open(filename) do |file|
        file.read.split(/\n|\r|\r\n/).each do |line|
          next if line.empty? # 空行はスキップ
          next if line.match(/^\/\//) # コメント行はスキップ
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
      return nil if not hasMoreCommand?
      @command = @file.shift
      @command
    end

    def commandType
      types = ['A_COMMAND', 'C_COMMAND', 'L_COMMAND']
      if @command.match(/@([0-9]+|\w+)/)
        types[0]
      elsif @command.match(/=|;/)
        types[1]
      elsif @command.match(/^\([A-Z]+\)$/)
        types[2]
      else raise "@command did not match any types of commands."
      end
    end

    def symbol
      return nil if commandType == 'C_COMMAND'
      if commandType == 'A_COMMAND'
        match = @command.match(/@(\w+)/)
        match[1]
      elsif commandType == 'L_COMMAND'
        match = @command.match(/^\(([A-Z]+)\)/)
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
      symbol.to_i.to_s(2).rjust(16, '0')
    end

    private

    def parse(command)
      return nil if commandType != 'C_COMMAND'
      command.match(/(\w+)?=?(\w+[\+\-\&\|]?\w*);?(\w+)?/)
    end
  end
end
