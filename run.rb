#!/usr/bin/env ruby

require 'bundler/setup'
require 'httparty'
require 'git'

class ChangeTracker
  attr_reader :url
  attr_accessor :file

  def initialize
    @file = 'index.html' 
    @url = 'http://videos.makeyourmove.tv/'
  end

  def find_changes
    content = HTTParty.get(self.url)
    file = self.file 
    
    File.open("#{file}", 'w') do |f|
      f.write(content)
      f.close
    end

    diff = `git diff #{file}`
  end
end

change_tracker = ChangeTracker.new
change_tracker.find_changes