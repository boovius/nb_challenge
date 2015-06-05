class EventsController < ApplicationController
  def create
    event_params = EventParams.new params
    if event_params.errors?
      render json: {'status' => event_params.error_messages}, status: 400
    else
      event = Event.create(
        date: event_params.date,
        kind: event_params.kind,
        user: event_params.user,
        data: event_params.data
      )
      if event
        render json: {'status' => 'ok'}, status: 200
      else
        render json: {'status' => 'serverError'}, status: 400
      end
    end
  end
end
