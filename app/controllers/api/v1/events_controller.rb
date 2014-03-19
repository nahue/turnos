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
        event_params = params[:models]["0"]

        if event_params[:id].present?
          @event = Event.find(event_params[:id])
          @event.title = event_params[:title]
          @event.start = event_params[:start]
          @event.end = event_params[:end]
          @event.startTimezone = event_params[:startTimezone]
          @event.endTimezone = event_params[:endTimezone]
          @event.description = event_params[:description]
          @event.recurrenceId = event_params[:recurrenceId]
          @event.recurrenceRule = event_params[:recurrenceRule]
          @event.recurrenceException = event_params[:recurrenceException]
          @event.isAllDay = event_params[:isAllDay]
          if @event.save
            @event.assign_resources(event_params)
          end
          Rabl.render(@event, 'events/show', :view_path => 'app/views/api/v1', :format => :json)
        end
      end

      def create
        event_params = params[:models]["0"]
        @event = Event.new(event_params)
        if @event.save
          @event.assign_resources(event_params)
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
