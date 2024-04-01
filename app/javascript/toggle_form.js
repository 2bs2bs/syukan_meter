document.addEventListener('turbo:load', function() {
  const toggleLink = document.getElementById('toggle-link');
  const emailForm = document.getElementById('email-form');
  const lineLogin = document.getElementById('line-login');

  toggleLink.addEventListener('click', function(event) {
    event.preventDefault();

    if (emailForm.classList.contains('hidden')) {
      // LINEログインを表示して、emailフォームを隠す
      emailForm.classList.remove('hidden');
      lineLogin.classList.add('hidden');
      toggleLink.textContent = 'LINEでの登録はこちら';
    } else {
      // emailフォームを表示して、LINEログインを隠す
      emailForm.classList.add('hidden');
      lineLogin.classList.remove('hidden');
      toggleLink.textContent = 'emailでの登録はこちら';
    }
  });
});