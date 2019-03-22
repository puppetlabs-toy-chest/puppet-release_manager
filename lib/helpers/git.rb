# frozen_string_literal: true

module ReleaseManager
  module Helpers
    module Git
      class << self
        def clone(url, name, opts)
          logger.info("Cloning #{url} - #{name}")
          ::Git.clone(url, name, opts)
        end

        def fetch_all
          @repo.fetch(all: true)
        end

        def checkout(branch)
          @repo.checkout(branch)
        end

        def use_repo(repo)
          @repo = ::Git.open(repo)
        end

        def describe(ref, opts)
          @repo.describe(ref, opts)
        end

        def commits_between(ref1, ref2)
          @repo.log.between(ref1, ref2).map(&:message)
        end

        def logger
          ReleaseManager.logger
        end
      end
    end
  end
end
