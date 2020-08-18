class HomesController < ApplicationController
    def top
        now = Time.current
        @events = Event.where('date >= ?', now)
    end

    def about
    end
end