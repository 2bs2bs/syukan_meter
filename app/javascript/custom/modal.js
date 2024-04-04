document.addEventListener('turbo:load', () => {
  const openModalButton = document.getElementById('open-modal-button');
  const modal = document.getElementById('new-modal');

  openModalButton.addEventListener('click', () => {
    modal.classList.remove('hidden');
    openModalButton.classList.add('hidden');
  });
});