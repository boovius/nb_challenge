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
end
