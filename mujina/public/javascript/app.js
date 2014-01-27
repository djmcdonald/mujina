var App = Ember.Application.create();

App.Channel = DS.Model.extend({
    title: DS.attr('string')
});

App.Router.map(function() {
    this.resource('channels');
});

App.Store = DS.Store.extend({
    adapter: 'DS.RESTAdapter'
});

DS.RESTAdapter.reopen({
    namespace: 'api/tv/guide'
});

App.ChannelsRoute = Ember.Route.extend({
    model: function() {
        return this.store.find('channel');
    }
});

App.IndexRoute = Ember.Route.extend({
    redirect: function() {
        this.transitionTo('channels');
    }
});