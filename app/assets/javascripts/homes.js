document.addEventListener('DOMContentLoaded', function() {
    const hero = new HeroSlider('.swiper-container');
    hero.start();
});

class HeroSlider {
    constructor(el) {
        this.el = el;
        this.swiper = this._initSwiper();
    }

    _initSwiper() {
        return new Swiper(this.el, {
            // Optional parameters
            // direction: 'vertical',
            loop: true,
            grabCursor: true,
            centeredSlides: true,
            spaceBetween: 20,
            slidesPerView: 2,
            speed: 1000,
            breakpoints: {
                1024: {
                    slidesPerView: 3,
                },
                1250: {
                    slidesPerView: 4,
                }
            },
        });
    }

    start(options = {}) {
        options = Object.assign({
            delay: 4000,
            disableOnInteraction: false
        }, options);

        this.swiper.params.autoplay = options;
        this.swiper.autoplay.start();
    }
    stop() {
        this.swiper.autoplay.stop();
    }
}