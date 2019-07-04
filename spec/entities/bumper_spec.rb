# frozen_string_literal: true

describe ReleaseManager::Entities::Bumper do
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:branch) }
  it { is_expected.to respond_to(:path) }
  it { is_expected.to respond_to(:version) }
end
