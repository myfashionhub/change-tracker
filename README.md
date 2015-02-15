## Ruby script for tracking changes

### Getting started
* This assumes your machine has Ruby environment. Clone the repo, cd into it and run `bundle install` to install dependencies (`gem install bundle` if gem bundle is not already installed).

* How it works: The script downloads the page/file you specify and git commits any change it detects. It can be set up to run at intervals with crontab. `git push --quiet` option means you will only get notified by email if an error is encountered.

#### If system Ruby is installed:
* Replace the top line of run.rb with:
`#!/usr/bin/env ruby`

* Edit crontab with `crontab -e`:
```bash
MAILTO="[your email]"
# every 10 minutes
*/10 * * * * path/to/file/run.rb
```

#### If Ruby is installed with RVM:
* Get Ruby binary: `which ruby`

* In crontab:
```bash
MAILTO="[your email]"
*/10 * * * * [Ruby binary] all ruby do path/to/file/run.rb
```

[Scripting with Ruby Tutorial](http://www.dreamsyssoft.com/ruby-scripting-tutorial/ifelse-tutorial.php)
