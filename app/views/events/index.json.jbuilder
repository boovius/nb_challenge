json.events @events do |event|
  json.date event.date.iso8601
  json.user event.user
  json.kind event.kind
  if event.kind == 'comment'
    json.message event.data
  elsif event.kind == 'highfive'
    json.otheruser event.data
  end
end
