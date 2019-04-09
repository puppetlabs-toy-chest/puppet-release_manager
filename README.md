Release Manager
===

 * Overview
 * Check components diff

Overview
---

The purpose of this project is to bring together the automation scripts 
for the puppet-agent release.

Check components diff
---

What it does:
  1. Creates a new directory within this project called `new_release`
  2. Clones `puppet-agent` and all of its dependencies in that directory
  3. Outputs all the new commits for each component since the last release
  4. Outputs a table with the revision and the next revision number for each component

To run the script:
  1. Clone the project
  2. `cd <path/to/project>`
  3. run `bundle install`
  4. `ruby bin/check_components_diff.rb <source_branch> <release_type>` 
  (please note that the source_branch is mandatory and release_type is 'z' by default)
  