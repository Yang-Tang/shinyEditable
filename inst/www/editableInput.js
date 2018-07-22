
var editableInputBinding = new Shiny.InputBinding();

$.extend(editableInputBinding, {

  find: function(scope) {
    console.log("find");
    return $(scope).find('.shinyEditable-bound-input');
  },

  getId: function(el) {
    console.log("getId");
    return el.id;
  },

  getValue: function(el) {
    console.log("getValue");
    return $(el).text();
  },

  setValue: function(el, value) {
    console.log("setValue");
    $(el).text(value);
  },

  subscribe: function(el, callback) {
    console.log("subscribe");
    $(el).on("init.editableInputBinding", function(e, editable) {
      console.log("init");
      callback();
    });
    $(el).on("save.editableInputBinding", function(e, params) {
      console.log("save");
      // wait for text update
      setTimeout(function() { callback(); }, 10);
    });

  },

  unsubscribe: function(el) {
    $(el).off('.editableInputBinding');
  },

  receiveMessage: function(el, data) {
    if (data.hasOwnProperty('value'))
      this.setValue(el, data.value);

    $(el).trigger('save');
  },

  getState: function(el) {
    return {
      value: this.getValue(el)
    };
  },

  getRatePolicy: function() {
    return {
      // Can be 'debounce' or 'throttle'
      policy: 'debounce',
      delay: 500
    };
  }
});

Shiny.inputBindings.register(editableInputBinding, 'shiny.urlInput');
