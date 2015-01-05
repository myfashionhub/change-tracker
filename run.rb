require 'httparty'

class ChangeTracker
  def pages 
    urls = ['http://videos.makeyourmove.tv/']
  end

  def find_changes
    pages = self.pages
    puts pages
  end
end

change_tracker = new ChangeTracker
change_tracker.find_changes