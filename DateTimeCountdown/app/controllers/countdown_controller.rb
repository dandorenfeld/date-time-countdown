class CountdownController < ApplicationController

    # Note: Constants cannot be assigned inside of a method
    ONE_SECOND = 1
    ONE_MINUTE = 60 * ONE_SECOND   #     60 seconds
    ONE_HOUR   = 60 * ONE_MINUTE   #  3,600 seconds
    ONE_DAY    = 24 * ONE_HOUR     # 86,400 seconds
    FIVE_PM    = 17 * ONE_HOUR     # 61,200 seconds (since midnight)

    def home
      # Calculate the total days including weekends
      # Calculate the days left without weekends and arbitrary time off
      ### Todo: Use MST, MDT to ensure the proper day
      ### Todo: Use pro-rated calculation to determine number of days off
      @days_gross = (DateTime.new(2014,9,30) - Date.today).to_i
      @days_left = @days_gross - (@days_gross / 7 * 2)
      @days_left = @days_left - 10

      # Calculate the partial day
      time_now = Time.now.in_time_zone("Mountain Time (US & Canada)")
      @time_now_formatted = time_now.strftime("%A - %B %d, %Y; %I:%M%p %Z")
      @hours_left         = 0
      @minutes_left       = 0
      @seconds_left       = 0
      unless time_now.saturday? || time_now.sunday?
        # The end of the day is 5:00 PM today
        partial_day = FIVE_PM - time_now.seconds_since_midnight
        if partial_day > 0
          # Since we are using Time, we need to truncate (remove) the decimal
          @hours_left   =  (partial_day / ONE_HOUR).truncate
          @minutes_left = ((partial_day % ONE_HOUR) / ONE_MINUTE).truncate
          @seconds_left = ((partial_day % ONE_HOUR) % ONE_MINUTE).truncate
        end
      end

      render :action => "countdown"
    end

end
