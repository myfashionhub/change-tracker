#!/home/nessa/.rvm/rubies/ruby-2.1.5/bin/ruby

# /usr/bin/env ruby

require 'bundler/setup'
require 'httparty'
require 'date'

class ChangeTracker
  attr_reader :url
  attr_accessor :file, :draft

  def initialize
    @draft = 'draft.html'
    @file  = 'index.html' 
    @url   = 'http://videos.makeyourmove.tv/'
  end

  def find_changes
    content = HTTParty.get(self.url)
    file    = self.file
    draft   = self.draft 
    message = "Changes detected #{DateTime.now}"
    path    = "/home/nessa/waywire-bot/makeyourmovetv/"

    File.open("#{draft}", 'w') do |f|
      f.write(content)
      f.close
    end

    File.open("#{path}#{file}", 'w') do |f|
      File.readlines("#{path}#{draft}").each do |line|
        unless line.include?('decor/track/dot') || 
          line.include?('media_player_insertion_')
          f.write(line)
        end  
      end  
      f.close
    end

    diff = `cd #{path} && git diff #{file}`
    unless diff.empty?
      add = system "cd #{path} && git add #{file}"
      if add 
        commit = system "#{cd} && git commit -m '#{message}'"
        if commit 
          system "cd #{path} && git push --quiet origin master"
        end 
      end    
    end
  end
end

change_tracker = ChangeTracker.new
change_tracker.find_changes