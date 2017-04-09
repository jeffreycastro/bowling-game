class Frame
  attr_accessor :pins, :frame_number

  def initialize(pins, frame_number)
    @pins = pins
    @frame_number = frame_number
  end

  def validate_frame
    has_error = false
    if invalid_frame
      puts "Invalid input: Frame ##{frame_number + 1} is invalid."
      has_error = true
    end

    has_error
  end

  def invalid_frame
    cond1 = pins.empty?
    cond2 = pins.size == 1 && !strike?
    cond3 = pins.size >=2 && strike? && !last_frame?
    cond4 = pins.size > 2 && !last_frame?
    cond5 = pins.size > 2 && last_frame? && !strike?
    cond6 = pins.size < 3 && last_frame? && strike?
    cond7 = pins.size > 3
    cond8 = frame_score > 10 && !last_frame?
    cond9 = pins.count { |pin| pin < 0 || pin > 10 } > 0
    cond1 || cond2 || cond3 || cond4 || cond5 || cond6 || cond7 || cond8 || cond9
  end

  def strike?
    pins.first == BowlingGame::STRIKE_SCORE
  end

  def last_frame?
    frame_number == BowlingGame::LAST_FRAME
  end

  def frame_score
    pins.inject(0, :+)
  end

  def total_frame_score(next_frames)
    return frame_score if !strike? || last_frame?
    return frame_score + next_frames.map(&:pins).flatten.first(2).inject(0, :+) if next_frames && next_frames.first.strike?
    return frame_score + next_frames.first.frame_score
  end
end
