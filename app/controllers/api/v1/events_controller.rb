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
        if params[:models]["0"][:id].present?
          @event = Event.find(params[:models]["0"][:id])
          @event.update(params[:models]["0"])
          # get ResourceTypes array
          types = ResourceType.all.map {|m| m.multiple? ? m.title : m.field}
          types.each do |type|
            resources = @event.resources.includes(:resource_type).where("resource_types.title == ? OR resource_types.field == ? ", type, type)
            resource_ids = resources.map {|r| r.id}
            ids = (params[:models]["0"][type].is_a? Array) ? params[:models]["0"][type].map {|a| a.to_i} : params[:models]["0"][type].to_i

            binding.pry
            # checks if related resources matches resources given by POST request
            if !resource_ids.empty? && (resource_ids != ids)
              @event.resources.destroy resources
            end



            unless resource_ids == ids
              unless ids == 0
                if ids.is_a? Integer
                  @event.resources << Resource.find(ids)
                else
                  ids.each do |id|
                    @event.resources << Resource.find(id)
                  end
                end
              end
            end

          end

          Rabl.render(@event, 'events/show', :view_path => 'app/views/api/v1', :format => :json)
        end
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
