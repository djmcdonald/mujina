(function ($) {
    _.templateSettings.variable = "rc";

    var Show = Backbone.RelationalModel.extend({
        width: function() {
            return (this.get('duration') / 3600) * 83;
        },
        show_description: function() {
            var description = this.get('title');

            if (this.get('description')) {
                description += ' - ' + this.get('description');
            }

            return description;
        },
        popover: function() {
            var start = moment(this.get('start_time'), 'YYYY-MM-DD HH:mm:ss Z').format('HH:mmA');
            var end = moment(this.get('end_time'), 'YYYY-MM-DD HH:mm:ss Z').format('HH:mmA');
            var popover = "";
            if (this.get('description')) {
                popover += "<p>"
                    + this.get('description')
                    + "</p>";
            }

            popover += "<p>" + start + " - " + end + "</p>";
            popover += "<p>" + this.duration_in_minutes() + " minutes</p>"

            return popover;
        },
        duration_in_minutes: function() {
            var start = moment(this.get('start_time'), 'YYYY-MM-DD HH:mm:ss Z');
            var end = moment(this.get('end_time'), 'YYYY-MM-DD HH:mm:ss Z');
            return end.subtract(start).format('m');
        }
    });

    var ShowCollection = Backbone.Collection.extend({
       model: Show
    });

    var Channel = Backbone.RelationalModel.extend({
        relations: [{
            type: Backbone.HasMany,
            key: 'shows',
            relatedModel: Show,
            collectionType: ShowCollection
        }]
    });

    var ChannelCollection = Backbone.Collection.extend({
        model: Channel
    });

    var Guide = Backbone.RelationalModel.extend({
        defaults: {
            duration: 1,
            end_time: null,
            start_time: null
        },

        relations: [{
            type: Backbone.HasMany,
            key: 'channels',
            relatedModel: Channel,
            collectionType: ChannelCollection
        }],

        time_ranges : function() {
            // Fixed at four intervals for now.
            var time_format = 'HH:mm';
            var start = moment(this.get('start_time'), 'YYYY-MM-DD HH:mm:ss Z');
            var interval = this.get('duration') / 4;
            return [
                start.format(time_format),
                start.add('seconds', interval).format(time_format),
                start.add('seconds', interval).format(time_format),
                start.add('seconds', interval).format(time_format)
            ];
        },
        currently_browsing: function() {
            //Fri Feb 21, 2014, 09:00 PM
            return moment(this.get('start_time'), 'YYYY-MM-DD HH:mm:ss Z').format('ddd Do MMM, YYYY, hh:mmA');
        }
    });

    var GuideCollection = {};

    GuideCollection.Collection = Backbone.Collection.extend({
        model: Guide,
        url: '/api/tv/guide/channels/2014-02-08+11:00:00'
    });

    GuideCollection.Views = {};

    GuideCollection.Views.List = Backbone.View.extend({
        initialize: function () {
            this.collection.bind('add', this.render, this);
        },
        render: function () {
            this.collection.each(function (model) {
                _.extend(model, viewHelpers);
                var template = _.template( $("#channels-template").html(), model);
                $('#tv-guide').html( template );

                $('.show-popover').popover({
                    placement: 'bottom',
                    trigger: 'hover',
                    html: true
                });
            }, this);
        }
    });

    $(function () {
        var collection = new GuideCollection.Collection(),
            view = new GuideCollection.Views.List({
                collection: collection
            });

        collection.fetch();
    });


})(jQuery);
