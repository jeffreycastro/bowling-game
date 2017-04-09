require_relative 'frame'

class BowlingGame
  STRIKE_SCORE = 10
  TOTAL_FRAMES = 10
  LAST_FRAME = 9

  attr_accessor :frames

  def initialize(argument)
    @argument = argument
    @frames = parse_input
    validate_game
    validate_frames
  end

  def validate_game
    has_error = false
    if invalid_argument_count
      puts "Invalid number of arguments."
      puts "Sample usage: ruby bowling.rb [[6,2],[9,1],[1,8],[10],[4,1],[5,2],[0,3],[10],[7,0],[10,7,2]]"
      has_error = true
    end

    if invalid_frame_count
      puts "Invalid number of frames. Input exactly 10 frames."
      has_error = true
    end

    if has_error
      puts "Check https://github.com/jeffreycastro/bowling-game for help on how to use the script."
      exit
    end
  end

  def validate_frames
    frames_validation = frames.map { |x| x.validate_frame }
    exit if frames_validation.include? true
  end

  def invalid_argument_count
    @argument.nil? || @argument.count != 1
  end

  def invalid_frame_count
    frames.size != TOTAL_FRAMES
  end

  def parse_input
    input = []
    @argument.first.split('[').delete_if { |x| x=="" }.each_with_index do |arg, i|
      input << Frame.new(arg.gsub("]","").split(",").map(&:to_i), i)
    end
    input
  end

  def game_score
    score = 0
    frame_scores = []
    frames.each do |frame|
      next_frames = next_frames(frames, frame.frame_number)
      score += frame.total_frame_score(next_frames)
      frame_scores << score
    end
    puts frame_scores.to_s
  end

  def next_frames(frames, current_frame)
    return if current_frame == LAST_FRAME
    return [frames[current_frame + 1]] if current_frame == (LAST_FRAME - 1)
    [frames[current_frame + 1], frames[current_frame + 2]]
  end
end
