lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "pry-byebug"
require_relative "lib/stree"

# syntax_tree
#
#          root - OP_ADD
#     ______|______
#    |              |
# left1 = 2       right1 = OP_SUB
#                 ___|___
#                |       |
#           right11=3  right11=1

root = STree::Node.new
tree = STree::Tree.new(root)
root.value = STree::Operations::OP_ADD
left1 = STree::Node.new
left1.value = 2
right1 = STree::Node.new
right1.value = STree::Operations::OP_SUB

right11 = STree::Node.new
right11.value = 3
right12 = STree::Node.new
right12.value = 1

root.rightNode = right1
root.leftNode = left1

right1.leftNode = right11
right1.rightNode = right12

p tree.exec_calculation

