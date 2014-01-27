var App = Ember.Application.create();

App.Show = DS.Model.extend({
    title: DS.attr('string')
});

App.Router.map(function() {
    this.resource('shows');
});

App.Store = DS.Store.extend({
    adapter: 'DS.RESTAdapter'
});

DS.RESTAdapter.reopen({
    namespace: 'api'
});

App.ShowsRoute = Ember.Route.extend({
    model: function() {
        return this.store.find('show');
    }
});

App.IndexRoute = Ember.Route.extend({
    redirect: function() {
        this.transitionTo('shows');
    }
});