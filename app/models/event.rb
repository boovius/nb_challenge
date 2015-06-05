class Event < ActiveRecord::Base
  class << self
    def save_with_params params
      self.create(
        date: params.date,
        kind: params.kind,
        user: params.user,
        data: params.data
      )
    end
  end
end
