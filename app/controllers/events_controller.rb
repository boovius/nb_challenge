class EventsController < ApplicationController
  def create
    event_params = EventParams.new params
    if event_params.errors?
      render json: {'status' => event_params.error_messages}, status: 400
    else
      event = Event.save_with_params(event_params)
      if event
        render json: {'status' => 'ok'}, status: 200
      else
        render json: {'status' => 'serverError'}, status: 400
      end
    end
  end

  def index
    @events = Event.where(date: from_utc..to_utc)
  end

  def summary
    byebug
    @aggregates = []
    segment_beginning = start
    segment_end = calc_seg_end(segment_beginning)
    while segment_end < loop_end do
      events_per_segment = Event.where(date: segment_beginning...segment_end)
      @aggregates << Aggregate.new(segment_beginning, events_per_segment)
      segment_beginning = segment_end
      segment_end = calc_seg_end(segment_beginning)
    end
    @aggregates
  end

  private

  def from_utc
    Time.parse(params['from'] || params[:from]).utc
  end

  def to_utc
    Time.parse(params['to'] || params[:to]).utc
  end

  def time_frame
    @timeframe ||= params['timeframe'] || params[:timeframe]
  end

  def start
    from_utc.send("beginning_of_#{time_frame}")
  end

  def loop_end
    to_utc.send("beginning_of_#{time_frame}")
  end

  def calc_seg_end(segment_beginning)
    segment_beginning +
    case time_frame
    when 'minute'
      60.seconds
    when 'hour'
      60*60.seconds
    when 'day'
      60*60*24.seconds
    end
  end
end
