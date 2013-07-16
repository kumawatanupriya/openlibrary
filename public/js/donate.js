var DonateBookView = Backbone.View.extend({
  initialize: function(){
    this.setElement($(".donate"));
  },

  events: {
    "change input.barcode": "saveBook",
    "click input[value=Add]": "addCopies"
  },

  saveBook: function(event){
    var postReq = $.post("/donate", {isbn: $(event.target).val()}, $.proxy(this.updateBookInfo, this))
  },

  addCopies: function(){
    $.blockUI();
    var params = {isbn: $("input[name=isbn]").val(), copies_to_add: $("input[type=number]").val()};
    var postReq = $.post("/add_copies", params, $.proxy(this.updateBookInfo, this));
    postReq.fail(function(){alert("error occurred")});
    postReq.always(function(){$.unblockUI()});
  },

  updateBookInfo: function(responseText) {
    $(this.el).find(".book-info").replaceWith(responseText);
    $.unblockUI();
  } 
});

$(function() { new DonateBookView(); });
