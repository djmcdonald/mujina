(function ($) {
    $('tooltip').tooltip();
    _.templateSettings.variable = "rc";

    var Guide = {};

    Guide.Collection = Backbone.Collection.extend({
        url: '/api/tv/guide/channels'
    });

    Guide.Views = {};

    Guide.Views.List = Backbone.View.extend({
        initialize: function () {
            this.collection.bind('add', this.render, this);
        },
        render: function () {
            this.collection.each(function (model) {
                _.extend(model, viewHelpers);
                var template = _.template( $("#channels-template").html(), model.toJSON());
                $('#tv-guide').html( template );
            }, this);
        }
    });

    $(function () {
        var collection = new Guide.Collection(),
            view = new Guide.Views.List({
                collection: collection
            });

        collection.fetch();
    });


})(jQuery);
