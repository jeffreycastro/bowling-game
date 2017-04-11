class Frame
  MIN_THROWS_STRIKE = 1
  MIN_THROWS_NONSTRIKE = 2
  MAX_THROWS = 3
  MIN_FRAME_SCORE = 0
  MAX_FRAME_SCORE = 10

  attr_accessor :throws, :frame_number

  def initialize(throws, frame_number)
    @throws = throws
    @frame_number = frame_number
  end

  def validate_frame
    has_error = false
    if invalid_frame?
      puts "Invalid input: Frame ##{frame_number + 1} is invalid."
      has_error = true
    end

    has_error
  end

  def frame_score
    throws.inject(0, :+)
  end

  def total_frame_score(next_frames)
    return frame_score if !strike? || last_frame?
    return frame_score + next_frames.map(&:throws).flatten.first(2).inject(0, :+) if next_frames && next_frames.first.strike?
    return frame_score + next_frames.first.frame_score
  end

  def strike?
    throws.first == BowlingGame::STRIKE_SCORE
  end

  private
  def invalid_frame?
    empty_throws? || too_many_throws? || frame_score_exceed? || pin_invalid_value_range? || non_strike_few_throws? || non_strike_too_many_throws? || non_strike_last_frame_frame_score_exceed? || strike_too_many_throws? || last_frame_non_strike_too_many_throws? || last_frame_strike_few_throws? || last_frame_strike_bonus_exceed?
  end

  def empty_throws?
    throws.empty?
  end

  def too_many_throws?
    throws.size > MAX_THROWS
  end

  def frame_score_exceed?
    frame_score > MAX_FRAME_SCORE && !last_frame?
  end

  def pin_invalid_value_range?
    throws.count { |pin| pin < MIN_FRAME_SCORE || pin > MAX_FRAME_SCORE } > 0
  end

  def non_strike_few_throws?
    throws.size < MIN_THROWS_NONSTRIKE && !strike?
  end

  def non_strike_too_many_throws?
    throws.size > MIN_THROWS_NONSTRIKE && !last_frame?
  end

  def non_strike_last_frame_frame_score_exceed?
    frame_score > MAX_FRAME_SCORE && last_frame? && !strike?
  end

  def strike_too_many_throws?
    throws.size != MIN_THROWS_STRIKE && !last_frame? && strike?
  end

  def last_frame_non_strike_too_many_throws?
    throws.size > MIN_THROWS_NONSTRIKE && last_frame? && !strike?
  end

  def last_frame_strike_few_throws?
    throws.size < MAX_THROWS && last_frame? && strike?
  end

  def last_frame_strike_bonus_exceed?
    last_frame? && strike? && (throws[1] != BowlingGame::STRIKE_SCORE) && (last_frame_strike_bonus_throws_score > MAX_FRAME_SCORE)
  end

  def last_frame?
    frame_number == (BowlingGame::TOTAL_FRAMES - 1)
  end

  def last_frame_strike_bonus_throws_score
    return 0 if !last_frame? && !strike?
    throws.last(2).inject(0, :+)
  end
end
