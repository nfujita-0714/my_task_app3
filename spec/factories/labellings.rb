FactoryBot.define do
  factory :labelling do
    association :label
    association :task
  end
end
