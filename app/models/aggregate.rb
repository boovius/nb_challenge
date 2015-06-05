class Aggregate
  attr_accessor :date, :enters, :leaves, :comments, :highfives

  def initialize(date, events)
    @date = date
    @enters = events.where(kind: :enter).count
    @leaves = events.where(kind: :leave).count
    @comments = events.where(kind: :comment).count
    @highfives = events.where(kind: :highfive).count
  end
end
