require_relative 'frame'

class BowlingGame
  STRIKE_SCORE = 10
  TOTAL_FRAMES = 10
  ARGV_SIZE = 1

  attr_accessor :frames

  def initialize(argument)
    @argument = argument
    @frames = parse_input
    validate_game
    validate_frames
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

  private
  def parse_input
    has_error = false
    if invalid_argument_count?
      puts "Invalid number of arguments."
      puts "Sample usage: ruby bowling.rb [[6,2],[9,1],[1,8],[10],[4,1],[5,2],[0,3],[10],[7,0],[10,7,2]]"
      has_error = true
    end
    exit if has_error

    eval(@argument.first).each_with_index.map{|x,i| Frame.new(x,i)}
  end

  def validate_game
    if invalid_frame_count?
      puts "Invalid number of frames. Input exactly #{TOTAL_FRAMES} frames."
      exit
    end
  end

  def validate_frames
    frames_validation = frames.map { |x| x.validate_frame }
    exit if frames_validation.include? true
  end

  def invalid_argument_count?
    @argument.empty? || @argument.count != ARGV_SIZE
  end

  def invalid_frame_count?
    frames.size != TOTAL_FRAMES
  end

  def next_frames(frames, current_frame)
    return if current_frame == (TOTAL_FRAMES - 1)
    return [frames[current_frame + 1]] if current_frame == (TOTAL_FRAMES - 2)
    [frames[current_frame + 1], frames[current_frame + 2]]
  end
end
