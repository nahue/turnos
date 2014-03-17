module Api
  module V1
    class EventsController < ApplicationController
      respond_to :json
      def index
        @events = Event.includes(:resources)
      end

      def show
        @event = Event.find(params[:id])
      end

      def update
        @event = Event.find(params[:models]["0"][:id])
        @event.update(params[:models]["0"])

        Rabl.render(@event, 'events/show', :view_path => 'app/views/api/v1', :format => :json)

      end

      def create
        @event = Event.new(params[:models]["0"])
        if @event.save
          Rabl.render(@event, 'events/show', :view_path => 'app/views/api/v1', :format => :json)
        end
      end

      def destroy
        @event = Event.find(params[:models]["0"][:id])
        @event.destroy
        Rabl.render(@event, 'events/show', :view_path => 'app/views/api/v1', :format => :json)
      end
    end
  end
end
