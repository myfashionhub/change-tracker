#!/home/nessa/.rvm/rubies/ruby-2.1.5/bin/ruby

# /usr/bin/env ruby

require 'bundler/setup'
require 'httparty'
require 'date'

class ChangeTracker
  attr_reader :url, :path
  attr_accessor :file, :draft

  def initialize
    # Url to the file that needs tracking
    # It can be any file type: css, js, xml
    @url   = 'http://yourwebsite.com/path/main.html'

    # Name these two files with corresponding extension
    @draft = 'draft.html'
    @file  = 'main.html'

    # Since cron runs at the root
    # We need to specify a path to the monitor folder
    @path  = '/path/to/local/folder/'
  end

  def find_changes
    file    = self.file
    draft   = self.draft
    path    = self.path
    message = "Changes detected #{DateTime.now}"

    # The script writes the file into the draft
    content = HTTParty.get(self.url)
    File.open("#{path}#{draft}", 'w') do |f|
      f.write(content)
      f.close
    end

    # Use this block to ignore any word or line
    # that constantly changes and doesn't need to be tracked
    ignored_lines = ['word1' 'line2', 'phrase3']
    File.open("#{path}#{file}", 'w') do |f|
      File.readlines("#{path}#{draft}").each do |line|
        ignored_lines.each do |ignore|
          f.write(line) unless line.include?(ignore)
        end
      end
      f.close
    end

    diff = `cd #{path} && git diff #{file}`
    unless diff.empty?
      add = system "cd #{path} && git add #{file}"
      if add
        commit = system "cd #{path} && git commit -m '#{message}'"
        if commit
          system "cd #{path} && git push --quiet origin master"
        end
      end
    end
  end
end

change_tracker = ChangeTracker.new
change_tracker.find_changes
