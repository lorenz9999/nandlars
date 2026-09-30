const galleryDialog = document.querySelector('.gallery-dialog');

if (galleryDialog) {
  const fullImage = galleryDialog.querySelector('img');
  const caption = galleryDialog.querySelector('p');
  const closeButton = galleryDialog.querySelector('.gallery-dialog-close');

  document.querySelectorAll('.gallery-photo').forEach((button) => {
    button.addEventListener('click', () => {
      const thumbnail = button.querySelector('img');
      fullImage.src = button.dataset.full;
      fullImage.alt = thumbnail.alt;
      caption.textContent = button.closest('figure').querySelector('figcaption').textContent;
      galleryDialog.showModal();
    });
  });

  closeButton.addEventListener('click', () => galleryDialog.close());
  galleryDialog.addEventListener('click', (event) => {
    if (event.target === galleryDialog) galleryDialog.close();
  });
  galleryDialog.addEventListener('close', () => {
    fullImage.src = '';
  });
}
