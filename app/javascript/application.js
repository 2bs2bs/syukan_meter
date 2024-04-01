// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "toggle_user_new_form"

// headerのnavber
document.addEventListener('turbo:load', () => {
  const avatar = document.getElementById('avatar');
  const navbar = document.getElementById('navbar');

  avatar.addEventListener('click', () => {
    navbar.classList.toggle('hidden');
  });
});