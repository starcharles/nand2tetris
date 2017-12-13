lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "pry-byebug"

# file= 'Add'
file= 'MaxL'

target = "./#{file}.hack"
src = './Prog.hack'

target_arr =[]
src_arr =[]

begin
  File.open(target) do |file|
    file.read.split(/\n|\r|\r\n/).each do |line|
      next if line.empty? # 空行はスキップ
      next if line.match(/^\/\//) # コメント行はスキップ
      target_arr.push(line)
    end
  end

  File.open(src) do |file|
    file.read.split(/\n|\r|\r\n/).each do |line|
      next if line.empty? # 空行はスキップ
      next if line.match(/^\/\//) # コメント行はスキップ
      src_arr.push(line)
    end
  end
rescue => e
  puts e.message
end

while comp = target_arr.pop
  src = src_arr.pop
  p comp == src
end

