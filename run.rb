require 'rubygems'
require 'bundler/setup'
require 'httparty'
require 'git'

class ChangeTracker
  def pages 
    urls = ['http://videos.makeyourmove.tv/']
  end

  def find_changes
    pages = self.pages
    puts pages
  end
end

change_tracker = ChangeTracker.new
change_tracker.find_changes