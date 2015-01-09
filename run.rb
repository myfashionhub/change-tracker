#!/home/nessa/.rvm/rubies/ruby-2.1.5/bin/ruby

# /usr/bin/env ruby

require 'bundler/setup'
require 'httparty'
require 'date'

class ChangeTracker
  attr_reader :url, :path
  attr_accessor :file, :draft

  def initialize
    @draft = 'draft.css'
    @file  = 'local_style.css' 
    @url   = 'http://media.magnify.net/media/site/G2P0Z22GWYF818G8/local_style.css'
    @path  = "/home/nessa/waywire-bot/makeyourmovetv/"
  end

  def find_changes
    file    = self.file
    draft   = self.draft 
    path    = self.path
    message = "Changes detected #{DateTime.now}"
    
    content = HTTParty.get(self.url)
    File.open("#{path}#{draft}", 'w') do |f|
      f.write(content)
      f.close
    end

    File.open("#{path}#{file}", 'w') do |f|
      File.readlines("#{path}#{draft}").each do |line|
        unless line.include?('decor/track/dot') || 
          line.include?('media_player_insertion_') || 
          line.include?('style/shared.css?') || 
          line.include?('local_style.css?')
          f.write(line)
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
