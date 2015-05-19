<% if @customer.errors.empty? %>

$('.newsletter__msg').html '<%= t(".success") %>'
$('.newsletter__input').val ''
$('.newsletter')
  .removeClass('newsletter--error')
  .addClass('newsletter--success')

setTimeout (-> $('.newsletter').removeClass 'newsletter--success' ), 5000

<% else %>

$('.newsletter__msg').html '<%= error_messages_for(@customer, length: 1).html_safe %>'
$('.newsletter')
  .removeClass('newsletter--success')
  .addClass('newsletter--error')

<% end %>
