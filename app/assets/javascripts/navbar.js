document.addEventListener("turbolinks:load", function () {
  const toggle = document.querySelector(".toggle");
  const menu = document.querySelector(".menu");
  const items = document.querySelectorAll(".item");

  /* Toggle mobile menu */
  function toggleMenu() {
    if (menu.classList.contains("active")) {
      menu.classList.remove("active");

      toggle.querySelector("a").innerHTML = '<i class="fas fa-bars"></i>';
    } else {
      menu.classList.add("active");

      toggle.querySelector("a").innerHTML = '<i class="fas fa-times"></i>';
    }
  }

  /* Event Listener */
  toggle.addEventListener("click", toggleMenu, false);

  /* Activate Submenu */
  function toggleItem() {
    if (this.classList.contains("submenu-active")) {
      this.classList.remove("submenu-active");
    } else if (menu.querySelector(".submenu-active")) {
      menu.querySelector(".submenu-active").classList.remove("submenu-active");
      this.classList.add("submenu-active");
    } else {
      this.classList.add("submenu-active");
    }
  }

  for (let item of items) {
    if (item.querySelector(".submenu")) {
      item.addEventListener("click", toggleItem, false);
      item.addEventListener("keypress", toggleItem, false);
    }
  }
})
