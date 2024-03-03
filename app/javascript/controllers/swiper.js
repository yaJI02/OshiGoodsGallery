document.addEventListener("turbo:load", function () {
  const swiper = document.querySelector(".swiper1");
  if (swiper) {
    const swiperOptions = {
      slidesPerView: 1,
      breakpoints: {
      768: {
        slidesPerView: 2,
      },
      992: {
        slidesPerView: 3,
      }
    },
      spaceBetween: 20,
      centeredSlides: true,

      pagination: {
        el: ".swiper-pagination",
        clickable: true,
      },

      navigation: {
        nextEl: ".swiper-button-next",
        prevEl: ".swiper-button-prev",
      },

      scrollbar: {
        el: ".swiper-scrollbar",
      },
    };

    const swipers = [".swiper1", ".swiper2", ".swiper3"];
    swipers.forEach(function (swiper_name) {
      let slideshow = document.querySelector(swiper_name);
      let slidesCount = slideshow.querySelectorAll(".swiper-slide").length;
      let autoplayEnabled = slidesCount > 3 ? true : false;
      let options = Object.assign({}, swiperOptions, {
        slidesPerView: slidesCount <= 3 ? slidesCount : 3,
        autoplay: autoplayEnabled
          ? {
              delay: 5000,
              disableOnInteraction: false,
            }
          : false,
      });
      new Swiper(swiper_name, options);
    });
  }
});