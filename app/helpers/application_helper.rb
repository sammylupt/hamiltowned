module ApplicationHelper
  def lottery_start
    DateTime.now.midnight.in_time_zone('Eastern Time (US & Canada)') + 9.hours
  end

  def lottery_end
    DateTime.now.midnight.in_time_zone('Eastern Time (US & Canada)') + 16.hours
  end

  def time_now
    DateTime.now.in_time_zone('Eastern Time (US & Canada)')
  end

  def in_lottery_sign_up_period?
    (lottery_start..lottery_end).cover?(time_now)
  end
end
