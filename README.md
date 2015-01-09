## Tracking changes on Makeyourmove.tv

### Run the script

#### If system Ruby is installed:
* Replace the top line of run.rb with:
`#!/usr/bin/env ruby`

* Edit crontab with `crontab -e`:
```
MAILTO="nessa@waywire.com"
# every 10 minutes
*/10 * * * * path/to/file/run.rb
```

#### If Ruby is installed with RVM:
* Get Ruby binary: `which ruby`

* In crontab:
```bash
MAILTO="nessa@waywire.com"
*/10 * * * * [Ruby binary] all ruby do path/to/file/run.rb
```

[Scripting with Ruby Tutorial](http://www.dreamsyssoft.com/ruby-scripting-tutorial/ifelse-tutorial.php)
