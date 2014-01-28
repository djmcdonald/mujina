var App = Ember.Application.create({
    LOG_TRANSITIONS: true,
    LOG_BINDINGS: true,
    LOG_VIEW_LOOKUPS: true,
    LOG_STACKTRACE_ON_DEPRECATION: true,
    LOG_VERSION: true,
    debugMode: true
});

App.Channel = DS.Model.extend({
    call_sign: DS.attr('string')
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
        return this.store.findAll('channel');
    }
});

App.IndexRoute = Ember.Route.extend({
    redirect: function() {
        this.transitionTo('channels');
    }
});