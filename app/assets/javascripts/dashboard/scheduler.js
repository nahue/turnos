$(function() {
    $("#scheduler").kendoScheduler({
        date: new Date("2014/3/1"),
        startTime: new Date("2014/3/1 07:00 AM"),
        height: 600,
        views: [
            "day",
            //{ type: "workWeek", selected: true },
            "week",
            { type: "month", selected: true },
            "agenda"
        ],
        timezone: "Etc/UTC",
        dataSource: {
            batch: true,
            transport: {
                read: {
                    url: "http://localhost:3000/api/v1/events.json",
                    dataType: "jsonp"
                },
                update: {
                    url: "http://localhost:3000/api/v1/events/update",
                    dataType: "jsonp",
                    type: 'PUT'
                },
                create: {
                    url: "http://localhost:3000/api/v1/events",
                    dataType: "jsonp",
                    type: 'POST'
                },
                destroy: {
                    url: "http://localhost:3000/api/v1/events/destroy",
                    dataType: "jsonp",
                    type: 'DELETE'
                }
            },
            schema: {
                model: {
                    id: "id",
                    fields: {
                        id: { from: "id", type: "number" },
                        title: { from: "title", defaultValue: "No title", validation: { required: true } },
                        start: { type: "date", from: "start" },
                        end: { type: "date", from: "end" },
                        startTimezone: { from: "startTimezone" },
                        endTimezone: { from: "endTimezone" },
                        description: { from: "description" },
                        recurrenceId: { from: "recurrenceId" },
                        recurrenceRule: { from: "recurrenceRule" },
                        recurrenceException: { from: "recurrenceException" },
                        isAllDay: { type: "boolean", from: "isAllDay" }
                    }
                }
            }
        }
    });

    $("#people :checkbox").change(function(e) {
        var checked = $.map($("#people :checked"), function(checkbox) {
            return parseInt($(checkbox).val());
        });

        var scheduler = $("#scheduler").data("kendoScheduler");

        scheduler.dataSource.filter({
            operator: function(task) {
                return $.inArray(task.ownerId, checked) >= 0;
            }
        });
    });
});
