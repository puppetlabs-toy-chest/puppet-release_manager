# frozen_string_literal: true

module ReleaseManager
  module Helpers
    module Git
      class << self
        def clone(url, path)
          `git clone --quiet #{url} #{path}`
        end

        def fetch_all
          `git fetch --all`
        end

        def checkout(branch)
          `git checkout --quiet #{branch}`
        end

        def use_repo(repo_path)
          prev_dir = file_helper.current_dir
          file_helper.chdir(repo_path)
          yield if block_given?
          file_helper.chdir(prev_dir)
        end

        def describe_tags(abbrev = true)
          return `git describe --tags --abbrev=0`.strip if abbrev

          `git describe --tags`.strip
        end

        def commits_between(ref1, ref2)
          `git log #{ref1}..#{ref2} --oneline`.split("\n")
        end

        def branch(remote = false)
          remote ? `git branch -r` : `git branch`
        end

        def commit(message)
          `git commit -a -m "#{message}"`
        end

        def push
          `git push`
        end

        def reset_hard(ref)
          `git reset --hard #{ref}`
        end

        private

        def file_helper
          Helpers::File
        end
      end
    end
  end
end
