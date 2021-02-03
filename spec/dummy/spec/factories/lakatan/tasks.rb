FactoryBot.define do
  factory :task, class: "Lakatan::Task" do
    team
    name { "Primera entrevista startup" }
    goal { "Ir a la primera entrevista startup PV" }
    raffle_type { "Random" }
    label_id { 0 }
    user_minimum { 1 }
  end
end
