class StatsController < ApplicationController
#count - how many rows wanted
#top - boolean - if you want to lower or higher end of the data

  def commands (count, top)
    if top
      CommandHistory.order("count ASC").limit(count).uniq
    else
      CommandHistory.order("count DESC").limit(count).uniq
    end
  end
  
  def top_users ( count )
    if top
      CommandHistory.order("count ASC").limit(count).uniq
    else
      CommandHistory.order("count DESC").limit(count).uniq
    end
  end
  
end
