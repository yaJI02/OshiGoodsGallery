document.addEventListener('turbo:load', function () {
  const shareBtn = document.getElementById('share-btn');
  if (shareBtn) {
    shareBtn.addEventListener('click', function () {
      let url = location.href;
      navigator.clipboard.writeText(url)
        .then(() => {
          document.getElementById('share-massage').textContent = 'URLがコピーされました！';
          setTimeout(refresh, 3000);
        })
        .catch((err) => {
          document.getElementById('share-massage').textContent = 'URLのコピーに失敗しました：';
          setTimeout(refresh, 3000);
        });
    });
  };
});

function refresh() {
  document.getElementById("share-massage").textContent ='';
};