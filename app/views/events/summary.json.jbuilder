json.aggregates @aggregates do |aggregate|
  json.date aggregate.date.iso8601
  json.enters aggregate.enters
  json.leaves aggregate.leaves
  json.comments aggregate.comments
  json.highfives aggregate.highfives
end
