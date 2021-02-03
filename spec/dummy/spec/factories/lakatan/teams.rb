FactoryBot.define do
  factory :team, class: "Lakatan::Team" do
    name { "Keepers of the seven keys" }
    purpose { "Definir cómo se entregan accesos y permisos a los distintos sistemas que necesitamos dentro de Platanus." }
  end
end
