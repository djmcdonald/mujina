(function ($) {
    _.templateSettings.variable = "rc";

    var Channels = {};

    Channels.Collection = Backbone.Collection.extend({
        url: '/api/tv/guide/channels'
    });

    Channels.Views = {};

    Channels.Views.List = Backbone.View.extend({
        initialize: function () {
            this.collection.bind('add', this.render, this);
        },
        render: function () {
            this.collection.each(function (model) {
                var template = _.template( $("#channels-template").html(), model.toJSON());
                // Load the compiled HTML into the Backbone "el"
                $('#content').html( template );
            }, this);
        }
    });

    $(function () {
        var collection = new Channels.Collection(),
            view = new Channels.Views.List({
                collection: collection
            });

        collection.fetch();
    });


})(jQuery);
