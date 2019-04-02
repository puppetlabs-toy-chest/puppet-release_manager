# frozen_string_literal: true

describe ReleaseManager::Entities::Component do
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:url) }
  it { is_expected.to respond_to(:ref) }
  it { is_expected.to respond_to(:promoted?) }
  it { is_expected.to respond_to(:path) }
end
