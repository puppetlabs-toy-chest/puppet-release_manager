# frozen_string_literal: true

FactoryBot.define do
  factory :promotion_changer, class: ReleaseManager::Common::PromotionChanger do
    source_branch { 'master' }

    initialize_with { new(source_branch) }
  end
end
