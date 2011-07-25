class TicTac
  attr_accessor :win_flag
  def initialize
    @arry = [["_","_","_"],["_","_","_"],["_","_","_"]]
    @count = 0
  end
  def write_board
    @arry.each do |row|
      row.each {|s| print "|" + s}
      print "|\n"
    end
  end
  def play
    define_attack_position
    @count += 1
    write_board
    judge
    print "\n"
  end
  def judge
    judge_eval(@arry[0][0],@arry[1][1],@arry[2][2])
    judge_eval(@arry[0][2],@arry[1][1],@arry[2][0])
    (0..2).each do |a|
      break if @win_flag
      judge_eval(@arry[a][0],@arry[a][1],@arry[a][2])
      judge_eval(@arry[0][a],@arry[1][a],@arry[2][a])
    end
  end
  def judge_eval(a,b,c)
    if (a != "_") && (a == b) && (b == c)
      puts a + " is win!!"
      @win_flag = true
    end
  end
  def define_attack_position
    (@count % 2 == 0) && (mark = "O") || mark = "X"
    rnum = rand(9)
    if @arry[rnum / 3][rnum % 3] == "_"
      @arry[rnum / 3][rnum % 3] = mark
    else
      define_attack_position
    end
  end
end
@tic = TicTac.new
(1..9).each  do |i|
  break if @tic.win_flag
  @tic.play
end
