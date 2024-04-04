// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "./custom/toggle_user_new_form"
import "./custom/modal"

// headerのnavber
document.addEventListener('turbo:load', () => {
  const avatar = document.getElementById('avatar');
  const navbar = document.getElementById('navbar');
  
  avatar.addEventListener('click', () => {
    navbar.classList.toggle('hidden');
  });
});
