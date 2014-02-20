(function ($) {
    $('tooltip').tooltip();
    _.templateSettings.variable = "rc";

    var Guide = Backbone.Model.extend({
        defaults: {
            duration: 1,
            end_time: null,
            start_time: null
        },
        time_ranges: function(){
            // Fixed at four intervals for now.
            var time_format = 'HH:mm';
            var start = moment(this.get('start_time'), 'YYYY-MM-DD HH:mm:ss');
            var interval = this.get('duration') / 4;
            return [
                start.format(time_format),
                start.add('seconds', interval).format(time_format),
                start.add('seconds', interval).format(time_format),
                start.add('seconds', interval).format(time_format)
            ];
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
