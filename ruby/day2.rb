# -*- coding: utf-8 -*-
#q1.eachメソッドで
a = (1..16).to_a
arry = []
a.each do |val|
  arry << val
  if arry.size == 4
    p arry.join(",")
    arry =[]
  end
end
#q1.each_sliceメソッドで
a.each_slice(4) do |arry|
  p arry
end

#Q2
class ATree
  attr_accessor :name,:children
  def initialize(hash)
    hash.each do |key,value|
      @name = key
      @children = value.map{ |k,v| ATree.new({ k => v })}
    end
  end

  def visit_all(&block)
    visit &block
    children.each{|c| c.visit_all &block}
  end
  def visit(&block)
    block.call self
  end
end
at = ATree.new({'grandpa'=>{'dad'=>{'child 1'=> {},'child 2' => {} },'uncle'=> {'child 3' => {}, 'child 4'=>{}}}})
at.visit{|atree| puts atree.name }
at.visit_all{|atree| puts atree.name }

#Q3
sample_txt = open("test.txt", "w")
test_arry = ["ukon","ukno"] * 10
test_arry << "unko"
100.times{sample_txt.puts "This sentence contains #{test_arry[rand(test_arry.size)]}!!"}
sample_txt.close

search_char = "unko"
search_file = open("test.txt", "r")
search_file.each_line do |line|
  if line =~ /#{search_char}/
    puts "#{$.}行目 : #{line}"
  end
end
search_file.close




# class Tree
# attr_accessor :name,:children
#   def initialize(name,children=[])
#     @name = name
#     @children = children
#   end
#   def visit(&block)
#     block.call self
# #    self.instance_eval &block
#   end
#   def visit_all(&block)
#     visit &block
#     children.each{|c| c.visit_all &block}
#   end
# end
# t = Tree.new("rb",[Tree.new("test"),Tree.new("test_value")])
# t.visit{|tree| puts tree.name }
# t.visit_all{|tr| puts tr.name }
# a = []
# for i in 1..16
#   a << i
# end
