#!/usr/bin/env ruby

require 'bundler/setup'
require 'httparty'
require 'date'

class ChangeTracker
  attr_reader :url
  attr_accessor :file, :draft

  def initialize
    @draft = 'draft.html'
    @file = 'index.html' 
    @url = 'http://videos.makeyourmove.tv/'
  end

  def find_changes
    content = HTTParty.get(self.url)
    file = self.file
    draft = self.draft 
    message = "Changes detected #{DateTime.now}"
    
    File.open("#{draft}", 'w') do |f|
      f.write(content)
      f.close
    end

    lines = []
    File.readlines("#{draft}").each do |line|
      unless line.include?('decor/track/dot') || 
        line.include?('media_player_insertion_')
        lines.push(line)
      end  
    end

    File.open("#{file}", 'w') do |f|
      lines.each do |line|
        f.write(line)
      end
      f.close
    end
    
    diff = `git diff #{file}`
    # unless diff.empty?
    #   add = system "git add #{file}"
    #   if add 
    #     commit = system "git commit -m '#{message}'"
    #     if commit 
    #       system "git push origin master"
    #     end 
    #   end    
    # end
  end
end

change_tracker = ChangeTracker.new
change_tracker.find_changes