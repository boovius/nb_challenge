FactoryGirl.define do
  factory :event do
    user 'richard nixon'

    factory :entry do
      kind :enter
    end

    factory :leave do
      kind :leave
    end

    factory :comment do
      kind :comment
      data "I'm not a crook"
    end

    factory :highfive do
      kind :highfive
      data 'bobby kennedy'
    end

    initialize_with do
      Event.new({})
    end
  end
end
