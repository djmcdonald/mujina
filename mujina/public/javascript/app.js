var App = Ember.Application.create();

App.Product = DS.Model.extend({
    title: DS.attr('string')
});

App.Router.map(function() {
    this.resource('products');
});

App.Store = DS.Store.extend({
    adapter: 'DS.RESTAdapter'
});

DS.RESTAdapter.reopen({
    namespace: 'api'
});

App.ProductsRoute = Ember.Route.extend({
    model: function() {
        return this.store.find('product');
    }
});

App.IndexRoute = Ember.Route.extend({
    redirect: function() {
        this.transitionTo('products');
    }
});