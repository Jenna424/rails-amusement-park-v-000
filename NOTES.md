<!--
<%= collection_select :user, :name, @users, :id, :name, {:include_blank => 'Please select'} %>
above generated the following HTML dropdown menu:

<select name="user[name]" id="user_name">
  <option value="">Please select</option>
  <option value="8">Jose</option>
  <option value="9">Max Charles</option>
  <option value="10">Skai Jackson</option>
  <option value="11">Kaleo Elam</option>
  <option value="12">Megan Charpentier</option>
  <option value="13">Hayden Byerly</option>
  <option value="14">Tenzing Norgay Trainor</option>
  <option value="15">Davis Cleveland</option>
  <option value="16">Cole Sand</option>
  <option value="17">Quvenzhané Wallis</option>
  <option value="18">Mary Elitch Long</option>
  <option value="19">John Elitch</option>
</select>

Note: If we DON'T use :url=>etc seen below, sign-in form data will be INCORRECTLY submitted
via post "/users" => 'users#create', as if we're registering and signing in a new user.
<%= form_for @user, :url => url_for(:controller => 'sessions', :action => 'create') do |f| %>
...
<% end %>
