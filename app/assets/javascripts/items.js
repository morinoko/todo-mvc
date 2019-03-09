function Item(attributes) {
  this.name = attributes.name;
  this.id = attributes.id;
}

Item.success = function(json) {
  // We want json to be a JS object of the item that was just created
  let item = new Item(json);
  let itemLi = item.renderLi();
  
  $("ul.todo-list").append(itemLi);
};

Item.error = function(error) {
  console.log("You broke it?", error);
};

Item.formSubmit = function(e) {
  e.preventDefault();
  
  // Put the item that triggered the event into a variable
  let $form = $(this);
  let action = $form.attr("action");
  let params = $form.serialize();
  
  // Send the form with AJAX
  $.ajax({
    url: action,
    data: params,
    dataType: 'json',
    method: "POST"
  })
  .success(Item.success)
  .error(Item.error);
};

Item.destroy = function(json) {
  let item = new Item(json);
  item.destroy();
};

Item.prototype.destroy = function() {
  $("li#item_" + this.id).remove();
};

Item.formSubmitListener =  function() {
  $("form#new_item").on("submit", Item.formSubmit);
}

Item.destroyListener = function() {
  $("ul.todo-list").on("click", "input.destroy", function(e) {
    e.preventDefault();
    
    let $form = $(this).parent("form");
    let action = $form.attr("action");
    let params = $form.serialize();

    $.ajax({
      url: action,
      data: params,
      dataType: 'json',
      method: "DELETE"
    })
    .success(Item.destroy);
  });
};

Item.ready = function() {
  Item.templateSource = $("#item-template").html();
  Item.template = Handlebars.compile(Item.templateSource);
  Item.formSubmitListener();
  Item.destroyListener();
}

Item.prototype.renderLi = function() {
  return Item.template(this)
};

$(function() {
  Item.ready();
});