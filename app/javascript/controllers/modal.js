document.addEventListener("turbo:load", function () {
  const openBtn = document.querySelector(".modal-open-btn");
  if (openBtn) {
    const modalShare = document.querySelector(".modal-share");
    const modalMask = document.querySelector(".modal-mask");

    openBtn.addEventListener("click", function () {
      modalShare.style.display = "block";
      modalMask.style.display = "block";
    });

    modalMask.addEventListener("click", function () {
      modalShare.style.display = "none";
      modalMask.style.display = "none";
    });
  }
});