## Tracking changes on Makeyourmove.tv

### Getting started
* This assumes your machine has Ruby environment. Clone the repo, cd into it and run `bundle install` to install dependencies (`gem install bundle`)

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
