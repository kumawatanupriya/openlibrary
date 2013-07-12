var DonateBookView = Backbone.View.extend({
  initialize: function(){
    this.setElement($(".donate"));
  },

  events: {
    "change input.barcode": "saveBook"
  },

  saveBook: function(event){
    $.post("/donate", {isbn: $(event.target).val()}, $.proxy(this.updateBookInfo, this))
  },

  updateBookInfo: function(responseText) {
    console.log(responseText)
    $(this.el).find(".book-info").replaceWith(responseText);
  } 
});

$(function() { new DonateBookView(); });
