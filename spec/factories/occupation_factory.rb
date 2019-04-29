# frozen_string_literal: true

FactoryBot.define do
  factory :occupation, class: 'Occupation' do
    sequence(:employer_name) { Faker::Company.name }
    sequence(:job_title) { Faker::Company.bs }
    sequence(:income) { Faker::Number.number(5) }
    #  sequence(:income_freq) {} #TODO: what values are these?

    #    has_one :address
  end
end
