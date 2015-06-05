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
    byebug
    from = params['from']
    to   = params['to']
    from_utc = Time.parse(from)
    to_utc = Time.parse(to)
    events = Event.where(date: from_utc..to_utc)
    render json: events, status: 200
  end
end
