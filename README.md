Release Manager
===

 * Overview
 * Initialize a new release environment
 * Components diff
 * Disable PE promotion

Overview
---

The purpose of this project is to bring together the automation scripts 
for the puppet-agent release.

Initialize a new release environment
---

To begin a new release:
  1. Clone this project
  (If already cloned, fetch the latest version (eg. `git pull`) and run the cleanup script: `ruby bin/cleanup.rb`)
  2. Make sure you have the correct version of ruby installed (2.6.1)
  3. Make sure `bundler` is installed
  4. `cd <path/to/project>`
  5. run `bundle install`
  6. run `ruby bin/initialize <source_branch>`  

What this does:
  1. Creates a new directory within this project called `new_release`
  2. Clones `puppet-agent` and all of its dependencies in that directory  

Components diff
---

What it does:
  1. Outputs all the new commits for each component since the last release
  2. Outputs the latest tag, suggested version and current version (from the version file) for each promoted component 

To run the script:
  1. `ruby bin/components_diff.rb <source_branch> <release_type>` 
  (please note that the source_branch is `master` and release_type is `z` by default)
  